FROM  public.ecr.aws/docker/library/maven:3.9-ibmjava-8 AS builder
COPY . /my-java
WORKDIR /my-java
RUN rm -rf /var/run/docker.pid
RUN mvn  package
# syntax=docker/dockerfile:1
# # Use an official Tomcat runtime as the base image
FROM public.ecr.aws/docker/library/tomcat:jre11
EXPOSE 8080
COPY --from=builder /my-java/ /usr/local/tomcat/webapps/
# RUN git clone github.com/Jayshreea0402/demo-java-eks
# WORKDIR cd /demo-java-eks
# RUN go build -o . 
# # # Remove the default Tomcat webapps to replace them with your application
# FROM public.ecr.aws/docker/library/tomcat:jre11
# 
# RUN rm -rf /usr/local/tomcat/webapps/*
# COPY  **/*.war /usr/local/tomcat/webapps/
#RUN rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get purge
# RUN mvn clean package
# COPY . .
# # Copy your built WAR file into the Tomcat webapps directory
# COPY target/my-java-app.war /usr/local/tomcat/webapps/ROOT.war
#RUN echo "export JAVA_OPTS=\"-Dapp.env=staging\"" > /usr/local/tomcat/bin/setenv.sh
#COPY pkg/demo.war /usr/local/tomcat/webapps/demo.war

# 
# # # Expose the Tomcat port (default is 8080)


# # # Start Tomcat when the container starts
# CMD ["catalina.sh", "run"]

# #COPY --from=builder *.war /usr/local/tomcat/webapps/
# syntax=docker/dockerfile:1
