# This guide contains 4 sections.
1. Setup fluent bit as sidecar to application container for log collection.
2. Configure fluent bit to send json logs to splunk.
3. Change application build process to write log files inside logs folder and change application.properties to produce json logs.
4. Change application code to produce valid log output.

### Setup fluent bit as sidecar to application container for log collection
1. The application container and fluent bit share logs through volume mounts. To achieve this, the deployment-config yaml of the application needs to have below sections added.
    ```
            - image: docker-remote.artifacts.developer.gov.bc.ca/fluent/fluent-bit:1.5.7
              name: "${APP_NAME}-${JOB_NAME}-fluent-bit-sidecar"
              imagePullPolicy: Always
              imagePullSecrets:
                - name: artifactory-creds
              volumeMounts:
                - name: log-storage
                  mountPath: /mnt/log
                - name: flb-sc-config-volume
                  mountPath: /fluent-bit/etc/
              readinessProbe:
                tcpSocket:
                  port: 2020
                initialDelaySeconds: 10
                periodSeconds: 30
                timeoutSeconds: 5
                failureThreshold: 5
                successThreshold: 1
              livenessProbe:
                httpGet:
                  path: /
                  port: 2020
                initialDelaySeconds: 10
                periodSeconds: 30
                timeoutSeconds: 5
                failureThreshold: 5
                successThreshold: 1
              ports:
                - containerPort: 2020
                  protocol: TCP
                  name: metrics
              resources:
                requests:
                  cpu: "5m"
                  memory: "25Mi"
                limits:
                  cpu: "10m"
                  memory: "50Mi"
    #inside application container
                      volumeMounts:
                        - name: tls-certs
                          mountPath: "/etc/tls-certs"
                          readOnly: true
                        - name: log-storage
                          mountPath: /logs
            volumes:
            - name: log-storage
              emptyDir: {}
            - name: flb-sc-config-volume
              configMap:
                name: "${APP_NAME}-flb-sc-config-map"
    ```
    
   [Working dc yaml sample] 

   https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/tools/openshift/api.dc.ocp4.yaml

### Configure fluent bit to send json logs to splunk
1. The fluent bit config map is volume mounted, only the splunk token and app name gets substituted as a secret while adding the config-map to OS. For more fluent-bit related docs please visit the below link.
   
   https://docs.fluentbit.io/manual/
   
   below is a working sample
    ```
    SPLUNK_URL="gww.splunk.educ.gov.bc.ca"
    FLB_CONFIG="[SERVICE]
       Flush        1
       Daemon       Off
       Log_Level    debug
       HTTP_Server   On
       HTTP_Listen   0.0.0.0
       Parsers_File parsers.conf
    [INPUT]
       Name   tail
       Path   /mnt/log/*
       Exclude_Path *.gz,*.zip
       Parser docker
       Mem_Buf_Limit 20MB
    [FILTER]
       Name record_modifier
       Match *
       Record hostname \${HOSTNAME}
    [OUTPUT]
       Name   stdout
       Match  *
    [OUTPUT]
       Name  splunk
       Match *
       Host  $SPLUNK_URL
       Port  443
       TLS         On
       TLS.Verify  Off
       Message_Key $APP_NAME
       Splunk_Token $SPLUNK_TOKEN
    "
    PARSER_CONFIG="
    [PARSER]
        Name        docker
        Format      json
    "
    
    below is for sample namespace and other variables needs to be properly substituted.
    
    echo Creating config map "$APP_NAME"-flb-sc-config-map
    oc create -n "$PEN_NAMESPACE"-"$envValue" configmap "$APP_NAME"-flb-sc-config-map --from-literal=fluent-bit.conf="$FLB_CONFIG" --from-literal=parsers.conf="$PARSER_CONFIG" --dry-run -o yaml | oc apply -f -

  2. full sample config-map setup link
   
     https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/tools/jenkins/update-configmap.sh
    
    

### Change application build process to write log files inside logs folder and change application.properties to produce json logs
1. Change Docker build process to create logs folder for your application container
    ```
    RUN useradd -ms /bin/bash spring
    RUN mkdir -p /logs
    RUN chown -R spring:spring /logs
    RUN chmod 755 /logs
    USER spring
    ```
    working full sample
   
    https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/Dockerfile


2. In Log pattern, Application code should only use line# and method name for debugging purposes, this is the reason these are not added, please see below explanation.
   ```
   M / method
   Outputs the method name where the logging request was issued.
   Generating the method name is not particularly fast. Thus, its use should be avoided unless execution speed is not an issue.
   
   L / line
   Outputs the line number from where the logging request was issued.
   Generating the line number information is not particularly fast. Thus, its use should be avoided unless execution speed is not an issue. 
  

3. Please follow this link of logback to know more details.
   
    http://logback.qos.ch/manual/layouts.html

4.  Add the below snippet to your application.properties file.

        logging.file.name=/logs/app.log
        logging.logback.rollingpolicy.max-file-size=5MB
        logging.logback.rollingpolicy.clean-history-on-start=true
        logging.logback.rollingpolicy.max-history=1
        logging.pattern.file={"time_stamp":"%d{yyyy-MM-dd HH:mm:ss.SSS}","level":"%3p" ,"thread":"%t" ,"class":"%logger{36}","msg":"%replace(%msg){'[\n\r\"]',''}", "exception":"%replace(%rEx{10}){'[\n\r\"]',''}","http_event":%X{httpEvent:-""},"message_event":%X{messageEvent:-""}}%nopex%n
        logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss.SSS} | [%5p] | [%t] | [%logger{36}] | [%replace(%msg){'[\n\r\"]',''} %X{httpEvent} %X{messageEvent}] | %replace(%rEx{10}){'[\n\r\"]',''}%nopex%n
5. Link
   
   https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/api/src/main/resources/application.properties

### Change application code to produce valid log output
1. Application code needs to be added/modified so that it produces a valid json o/p in log, For example 
   ```
   1. logging incoming http request and the outbound response 
   2. logging incoming message event 
   3. outbound http request and response
   ```
2. For http request and response logging with payload(POST or PUT), make sure the structs or dto or entities have proper toString() implementation for this to work. if the application is using lombok, and the struct extends to base class, please make sure lombok is generating toString for superclass fields as well(if needed) by adding `@ToString(callSuper=true)`. Then please add the following code 

        CustomRequestBodyAdviceAdapter
      https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/api/src/main/java/ca/bc/gov/educ/penreg/api/adapter/CustomRequestBodyAdviceAdapter.java
        
        LogHelper # logServerHttpReqResponseDetails method.
   https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/api/src/main/java/ca/bc/gov/educ/penreg/api/helpers/LogHelper.java 

3. For logging incoming message event just add below items.
    ```
   1. In the MessageSubscriber if it is NATS or Subscriber if it is JetStream
     LogHelper.logMessagingEventDetails(eventString);
     Sample
       https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/api/src/main/java/ca/bc/gov/educ/penreg/api/messaging/MessageSubscriber.java
       https://github.com/bcgov/EDUC-STUDENT-API/blob/master/api/src/main/java/ca/bc/gov/educ/api/student/messaging/jetstream/Subscriber.java
   
   2. Add this logMessagingEventDetails method to LogHelper
      public static void logMessagingEventDetails(final String event) {
        try {
          MDC.putCloseable("messageEvent", event);
          log.info("");
          MDC.clear();
        } catch (final Exception exception) {
          log.error("Exception ", exception);
        }
      }
      
   ```
       LogHelper#logMessagingEventDetails method.
   
   https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/api/src/main/java/ca/bc/gov/educ/penreg/api/helpers/LogHelper.java 
    
4. For logging outbound http request and response code just add below items to the application.
    ```
   1. Add below code to RestWebClient component
     .filter(this.log())
     private ExchangeFilterFunction log() {
       return (clientRequest, next) ->
         next.exchange(clientRequest)
           .doOnNext((clientResponse -> LogHelper.logClientHttpReqResponseDetails(clientRequest.method(), clientRequest.url().toString(), clientResponse.rawStatusCode(), clientRequest.headers().get(ApplicationProperties.CORRELATION_ID))));
     }
   
   2. Add this logClientHttpReqResponseDetails method to LogHelper
     public static void logClientHttpReqResponseDetails(@NonNull final HttpMethod method, final String url, final int responseCode, final List<String> correlationID) {
        try {
          final Map<String, Object> httpMap = new HashMap<>();
          httpMap.put("client_http_response_code", responseCode);
          httpMap.put("client_http_request_method", method.toString());
          httpMap.put("client_http_request_url", url);
          if (correlationID != null) {
            httpMap.put("correlation_id", String.join(",", correlationID));
          }
          MDC.putCloseable("httpEvent", mapper.writeValueAsString(httpMap));
          log.info("");
          MDC.clear();
        } catch (final Exception exception) {
          log.error("Exception ", exception);
        }
     }
    ```
       LogHelper#logClientHttpReqResponseDetails method.

   https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/api/src/main/java/ca/bc/gov/educ/penreg/api/helpers/LogHelper.java 
