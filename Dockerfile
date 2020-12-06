FROM ubuntu:18.04 AS builder

RUN apt-get -qq update && \
    apt-get -qq -y install default-jdk && \
    apt-get -qq -y install maven && \
    apt-get -qq -y install git && \
    apt-get -qq -y install mc && \
    mkdir /data && \
    cd /data && \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git && \
    cd /data/boxfuse-sample-java-war-hello && \
    mvn package


FROM tomcat:9.0.20-jre8-alpine
COPY --from=builder /data/boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/