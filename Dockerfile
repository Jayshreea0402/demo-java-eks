# # Use an official Tomcat runtime as the base image
FROM public.ecr.aws/docker/library/tomcat:jre11

# # Remove the default Tomcat webapps to replace them with your application
RUN rm -rf /usr/local/tomcat/webapps/*
RUN COPY target/demo.war /usr/local/tomcat/webapps/
#RUN rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get purge
# RUN mvn clean package
# COPY . .
# # Copy your built WAR file into the Tomcat webapps directory
# COPY target/my-java-app.war /usr/local/tomcat/webapps/ROOT.war
#RUN echo "export JAVA_OPTS=\"-Dapp.env=staging\"" > /usr/local/tomcat/bin/setenv.sh
#COPY pkg/demo.war /usr/local/tomcat/webapps/demo.war

EXPOSE 8080
# # Expose the Tomcat port (default is 8080)


# # Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
# syntax=docker/dockerfile:1
