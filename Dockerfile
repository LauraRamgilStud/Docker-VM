FROM openjdk:17-jdk-slim-bullseye
#Setting the working directory
WORKDIR /app
#Copy the mvn directory
COPY .mvn/ .mvn
#Copy the maven-wrapper and the pom file
COPY mvnw pom.xml ./
RUN apt-get update && apt-get install dos2unix
RUN dos2unix mvnw
#Run is docker way of telling it to do something. chmod is giving executable rights
#dependency:resolve looks in the pom.xml and retrieves all the dependencies
RUN chmod +x mvnw && ./mvnw dependency:resolve
#Copy the src folder
COPY src ./src
#Tells Docker to run this command, when our image is executed inside the container
CMD ["./mvnw", "spring-boot:run"]
