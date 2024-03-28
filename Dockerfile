FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk
WORKDIR /app
COPY --from=build /app/target/springboot-mongo-docker.jar /app/springboot-mongo-docker.jar
EXPOSE 9090
ENTRYPOINT ["java","-jar","springboot-mongo-docker.jar"]
