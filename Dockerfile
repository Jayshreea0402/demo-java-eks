FROM  public.ecr.aws/docker/library/maven:3.9-ibmjava-8 AS builder
COPY . /my-java
WORKDIR /my-java
RUN rm -rf /var/run/docker.pid
RUN mvn  package
##Stage 02
FROM public.ecr.aws/docker/library/tomcat:jre11 
EXPOSE 8080
COPY --from=builder /my-java/ /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]

