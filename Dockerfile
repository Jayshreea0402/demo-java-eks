# # Use an official Tomcat runtime as the base image
FROM public.ecr.aws/docker/library/tomcat:jre11

# # Remove the default Tomcat webapps to replace them with your application
RUN rm -rf /usr/local/tomcat/webapps/*
WORKDIR /my-java
RUN mvn clean package
COPY . .
# # Copy your built WAR file into the Tomcat webapps directory
# COPY target/my-java-app.war /usr/local/tomcat/webapps/ROOT.war

# # Expose the Tomcat port (default is 8080)
EXPOSE 8080

# # Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
# syntax=docker/dockerfile:1

EXPOSE 80

# Copy the generated static files from the builder stage
# to the Nginx server's default folder on the image
COPY --from=builder /my-project/dist/my-angular-project /usr/share/nginx/html
