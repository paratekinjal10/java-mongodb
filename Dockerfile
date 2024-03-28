FROM maven:3.6.3-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk
WORKDIR /app
COPY --from=build /app/target/springboot-mongo-docker.jar /app/springboot-mongo-docker.jar
EXPOSE 9090
ENTRYPOINT ["java","-jar","springboot-mongo-docker.jar"]
