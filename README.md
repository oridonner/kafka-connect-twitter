# Build Twitter Connector

Twitter connector build instructions [here](https://github.com/Eneco/kafka-connect-twitter#starting-kafka-connect-twitter).<br/>
This Connector works with **kafka 0.10** only, wasn't tested on **kafka 2.0**<br />


Copy _jar_ to **libs/**.

# Start _Kafka_ Cluster

## Start _Zookeeper_ 
Start _Zookeeper_ on localhost:2181 :
`./bin/zookeeper-server-start.sh config/zookeeper.properties`

## Start _Kafka_ Broker
Start a single _kafka_ broker on localhost:9092 :