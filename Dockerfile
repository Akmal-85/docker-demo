FROM umaven:3.9-eclips-temurin-17-alpine AS MAVEN_BUILD
MAINTAINER Akmal

COPY pom.xml /build/
COPY src /build/src/

WORKDIR /build/
RUN mvn package

FROM openjdk:17-oracle

WORKDIR /app

COPY --from=MAVEN_BUILD /build/target/docker*.jar /app/
CMD ["java", "-jar", "docker*.jar"]
