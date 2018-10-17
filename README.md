## Build _Twitter_ Connector

_Twitter_ connector build instructions [here](https://github.com/Eneco/kafka-connect-twitter#starting-kafka-connect-twitter).<br/>
This Connector works with **_kafka_ 0.10** only, wasn't tested on **_kafka_ 2.0**<br />

Copy _jar_ to **libs/**.

## Start _Zookeeper_ 
Start _Zookeeper_ on localhost:2181 :<br />
`./bin/zookeeper-server-start.sh config/zookeeper.properties`

## Start _Kafka_ Broker
Start a single _kafka_ broker on localhost:9092 :<br />
`./bin/kafka-server-start.sh config/server.properties`


## Start _Kafka Connect_
Start _Kafka Connect_ on distributed mode at localhost:8083 :<br />
`./bin/connect-distributed.sh config/connect-distributed.properties`

## 