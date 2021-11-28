FROM tomcat:9.0-jdk8
LABEL author="Mahesh babu"
LABEL organization="Quality thought"
EXPOSE 8080
COPY /game-of-life/gameoflife-web/target/gameoflife.war /usr/local/tomcat/webapps/gameoflife.war