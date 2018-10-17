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


## Start _Kafka Connect_ in distributed mode
Start _Kafka Connect_ on distributed mode at localhost:8083 :<br />
`./bin/connect-distributed.sh config/connect-distributed.properties`

#### Create _Twitter_ Connector

`echo '{"name": "source-twitter-distributed-1", "config":{"connector.class":"com.eneco.trading.kafka.connect.twitter.TwitterSourceConnector","tasks.max":"1","topic":"twitter-data","key.converter":"org.apache.kafka.connect.json.JsonConverter","key.converter.schemas.enable":"true","value.converter":"org.apache.kafka.connect.json.JsonConverter","value.converter.schemas.enable":"true","twitter.consumerkey":"WyBAPqB21h196UyENZATSnL3F","twitter.consumersecret":"jQtSGi0tynigU51EkSfCNahqrBkHE18cH0xU2FttVzTKpNbcJO","twitter.token":"908270057641463809-iju88vZOOTl2hiROMRA1XGLG1CnQPKI","twitter.secret":"r4L9oXix5wqoAD5GNIMtjRJOHuVO65mWLynhmmnD7sOW1","track.terms":"programming,java,kafka,scala","language":"en"}}' | curl -X POST -d @- http://localhost:8083/connectors --header "Content-Type:application/json"`<br/>

#### Twitter Access Tokens

Get/create _Twitter_ Access Token [here](https://apps.twitter.com/app/14818905/keys).<br/>
Twitter App name: Ori-Kafka-Connect-Demo<br />

## Start _Kafka Connect_ in standalone mode
You can also start the connector in standalone mode, based on [twitter-source-connector.properties](http://192.168.0.5/DataOps/twitter-source-connector/blob/master/config/twitter-source-connector.properties) connector config file:<br >
`./bin/connect-standalone.sh config/connect-standalone.properties config/twitter-source-connector.properties`

## Test
Test if topic **twitter-data** was created:<br />
`./bin/kafka-topics.sh --zookeeper localhost:2181 --list`

Test _Kafka Consumer_ topic output:
`./bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic twitter-data --from-beginning`

Data sample:
The data consists of **schema** and **payload** key:value pairs:
```perl
{"schema":{"type":"struct","fields":[{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"created_at"},{"type":"struct","fields":[{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"string","optional":true,"field":"screen_name"},{"type":"string","optional":true,"field":"location"},{"type":"boolean","optional":false,"field":"verified"},{"type":"int32","optional":false,"field":"friends_count"},{"type":"int32","optional":false,"field":"followers_count"},{"type":"int32","optional":false,"field":"statuses_count"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.User","field":"user"},{"type":"string","optional":true,"field":"text"},{"type":"string","optional":true,"field":"lang"},{"type":"boolean","optional":false,"field":"is_retweet"},{"type":"struct","fields":[{"type":"array","items":{"type":"struct","fields":[{"type":"string","optional":true,"field":"text"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Hashtag"},"optional":true,"field":"hashtags"},{"type":"array","items":{"type":"struct","fields":[{"type":"string","optional":true,"field":"display_url"},{"type":"string","optional":true,"field":"expanded_url"},{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"type"},{"type":"string","optional":true,"field":"url"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Medium"},"optional":true,"field":"media"},{"type":"array","items":{"type":"struct","fields":[{"type":"string","optional":true,"field":"display_url"},{"type":"string","optional":true,"field":"expanded_url"},{"type":"string","optional":true,"field":"url"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Url"},"optional":true,"field":"urls"},{"type":"array","items":{"type":"struct","fields":[{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"string","optional":true,"field":"screen_name"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.UserMention"},"optional":true,"field":"user_mentions"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Entities","field":"entities"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Tweet"},"payload":{"id":1052500156539658240,"created_at":"2018-10-17T10:02:46.000+0000","user":{"id":298914263,"name":"Jesús Sánchez","screen_name":"jesussp_","location":"México","verified":false,"friends_count":869,"followers_count":188,"statuses_count":1825},"text":"RT @javacodegeeks: How much faster is #Java 8? https://t.co/QMI2Fuj0Em","lang":"en","is_retweet":true,"entities":{"hashtags":[{"text":"Java"}],"media":[],"urls":[{"display_url":"buff.ly/2JH7qE5","expanded_url":"https://buff.ly/2JH7qE5","url":"https://t.co/QMI2Fuj0Em"}],"user_mentions":[{"id":150820027,"name":"Java Code Geeks","screen_name":"javacodegeeks"}]}}}
```
Or copy to JSON [online parser](http://json.parser.online.fr/)