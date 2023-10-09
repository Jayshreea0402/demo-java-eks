# Use an official Tomcat runtime as the base image
FROM tomcat:9-jre11

# Remove the default Tomcat webapps to replace them with your application
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your built WAR file into the Tomcat webapps directory
COPY target/my-java-app.war /usr/local/tomcat/webapps/ROOT.war

# Expose the Tomcat port (default is 8080)
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
