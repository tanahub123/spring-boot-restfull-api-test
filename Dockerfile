# Spring BootアプリをビルドするためMaven/Java8のDockerイメージを利用
FROM maven:3.5-jdk-8-alpine AS builder

# ビルド時のワークディレクトリの設定
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Maven packageでビルドとテストを実行し成果物(jarファイル)を作成
RUN mvn package

# Spring Bootアプリの実行環境にopenjdk:8-jre-alpineを利用
FROM openjdk:8-jre-alpine

COPY --from=builder /app/target/Spring-Boot-RESTful-API-Test-Sample-1.0.0-SNAPSHOT.jar /app.jar

# Docker Run時にjavaコマンドでSpring Bootを起動(Embedded Tomcatを起動)
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
