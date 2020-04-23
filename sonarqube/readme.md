# SonarQube Installation and Setup

We use the bcgov image of SonarQube.  Full instructions can be found on [DevHub](https://developer.gov.bc.ca/SonarQube-on-OpenShift)

To deploy SonarQube 
* clone this repository 
  ```
  git clone https://github.com/bcgov/EDUC-INFRA-COMMON.git
  ```
* Set the name of your project in the `properties/setup-sonarqube.properties` file
* If using Git Bash on Windows, first [download jq](https://stedolan.github.io/jq/download/) command and set JP_LOCATION value (in `properties/setup-sonarqube.properties`) to the path of the `jq-win64.exe` file.  Leave JP_LOCATION blank if running from Mac or Linux.
* Run the sonarqube-setup.sh script
  ```
  sonarqube-setup.sh
  ```


## Clean Up
To remove SonarQube run
```
oc -n <project>-tools delete all,template,secret,cm,pvc,sa,rolebinding --selector app=sonarqube
```
