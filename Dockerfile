FROM clojure:temurin-21-lein
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY receipt-processor/project.clj /usr/src/app
RUN lein deps
#TODO revisit where the Dockerfile will live (and therefore what "." will be
COPY ./receipt-processor /usr/src/app 
RUN mv "$(lein uberjar | sed -n 's/^Created \(.*standalone\.jar\)/\1/p')" app-standalone.jar

EXPOSE 8080

CMD ["java", "-jar", "app-standalone.jar"]
