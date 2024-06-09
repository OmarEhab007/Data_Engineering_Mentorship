# Servers Metrics & Logs
## Project Overview:
We have a cluste of 10 servers hosting a cloud storage website where users can upload and store different types of files. Beside these 10 servers we have a load balancer that acts as the main gateway for our website. We have deployed agents to these 10 servers and load balancer to collect metrics and logs.

Design a **Multi Node Kafka Cluster** where you would have two topics. One topic for the agents of the 10 servers which monitor resources consumption, the other topic for the agent of the load balancer which monitor logs. We have provided you with a java program which should simulate the agents sending data to the two topics.

After that, you need to build a consumers - in whatever language you would prefer- for the metrics that should send them to a relational database. For the logs, write a spark application that consumes them and calculate a moving windows count of every operation (no of successful GET operations, no of successful POST operations, no of failed GET operations, no of failed POST operations) every 5 mins and store the result into a hadoop system.

## Resources:
Java program to simulate the agents. You just need to install maven on your system and then run ```mvn exec:java``` to run the program

## Requirements:
1. Create the topics in the kafka cluster
2. Write consumer for the metrics
3. Write Spark application for logs

## Key Deliverables:
-	A document with the configuration of each broker and topic
-	Code for consumer and Spark application
