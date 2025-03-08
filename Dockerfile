FROM ubuntu:latest
ENV JAVA_HOME=/u01/middleware/jdk-11.0.2
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.100
ENV PATH=$PATH:${JAVA_HOME}/bin:${TOMCAT_HOME}/bin
RUN mkdir -p /u01/middleware
WORKDIR /u01/middleware
# Download and Install java 11
RUN apt update -y
ADD https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz .
RUN tar -xvzf openjdk-11.0.2_linux-x64_bin.tar.gz
RUN rm -rf openjdk-11.0.2_linux-x64_bin.tar.gz
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.100.tar.gz
RUN rm -rf apache-tomcat-9.0.100.tar.gz
RUN apt install -y curl
COPY config.properties /u01/middleware/
COPY target/urotaxi.war /${TOMCAT_HOME}/webapps
COPY run.sh /tmp
RUN chmod u+x /tmp/run.sh
ENTRYPOINT [ "/tmp/run.sh" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f http://localhost:8080/urotaxi/actuator/health || exit 1
