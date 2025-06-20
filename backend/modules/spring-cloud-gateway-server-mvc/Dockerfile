FROM gcr.io/distroless/java21-debian12:nonroot AS default
# 65532 is the nonroot user's uid
# used here instead of the name to allow Kubernetes to easily detect that the container
# is running as a non-root (uid != 0) user.
USER 65532:65532

COPY ./target/spring-cloud-gateway-server-mvc-0.0.1-SNAPSHOT.jar /opt/spring-cloud-gateway-server-mvc/gateway.jar

ENTRYPOINT ["java", "-jar", "/opt/spring-cloud-gateway-server-mvc/gateway.jar"]

# https://github.com/GoogleContainerTools/distroless
# https://spring.io/guides/gs/spring-boot-docker
