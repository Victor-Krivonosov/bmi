FROM maven:3.9.6-sapmachine-11 as build

COPY . .

RUN mvn clean package

FROM adoptopenjdk/openjdk11:jre11u-2024-01-25-20-19-beta-nightly

WORKDIR /app

COPY --from=build /target/bmi-1.0.jar /app/app.jar

RUN chmod 777 /app/app.jar

EXPOSE 8000

CMD ["java", "-jar", "/app/app.jar"]