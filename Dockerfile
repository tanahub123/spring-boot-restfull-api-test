# Spring Boot�A�v�����r���h���邽��Maven/Java8��Docker�C���[�W�𗘗p
FROM maven:3.5-jdk-8-alpine AS builder

# �r���h���̃��[�N�f�B���N�g���̐ݒ�
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Maven package�Ńr���h�ƃe�X�g�����s�����ʕ�(jar�t�@�C��)���쐬
RUN mvn package

# Spring Boot�A�v���̎��s����openjdk:8-jre-alpine�𗘗p
FROM openjdk:8-jre-alpine

COPY --from=builder /app/target/Spring-Boot-RESTful-API-Test-Sample-1.0.0-SNAPSHOT.jar /app.jar

# Docker Run����java�R�}���h��Spring Boot���N��(Embedded Tomcat���N��)
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
