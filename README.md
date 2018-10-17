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

## Create _Twitter_ Connector
Get/create _Twitter_ Access Token:https: //apps.twitter.com/
`echo '{"name": "source-twitter-distributed-1", "config":{"connector.class":"com.eneco.trading.kafka.connect.twitter.TwitterSourceConnector","tasks.max":"1","topic":"twitter-data","key.converter":"org.apache.kafka.connect.json.JsonConverter","key.converter.schemas.enable":"true","value.converter":"org.apache.kafka.connect.json.JsonConverter","value.converter.schemas.enable":"true","twitter.consumerkey":"WyBAPqB21h196UyENZATSnL3F","twitter.consumersecret":"jQtSGi0tynigU51EkSfCNahqrBkHE18cH0xU2FttVzTKpNbcJO","twitter.token":"908270057641463809-iju88vZOOTl2hiROMRA1XGLG1CnQPKI","twitter.secret":"r4L9oXix5wqoAD5GNIMtjRJOHuVO65mWLynhmmnD7sOW1","track.terms":"programming,java,kafka,scala","language":"en"}}' | curl -X POST -d @- http://localhost:8083/connectors --header "Content-Type:application/json"`