# This guide contains 4 sections.
1. Setup fluent bit as sidecar to application container for log collection.
2. Configure fluent bit to send json logs to splunk
3. Change application properties to produce json logs
4. Change application code to produce valid log output

#### Setup fluent bit as sidecar to application container for log collection
1. The application container and fluent bit share logs through volume mounts to achieve this, the deployment-config needs to have below sections added.
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
            
follow this link for a working sample
https://github.com/bcgov/EDUC-PEN-REG-BATCH-API/blob/master/tools/openshift/api.dc.yaml
```
