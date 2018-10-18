Build _Twitter_ Connector acoordinng to the instructions posted on [Robin Moffat's blog](https://www.confluent.io/blog/using-ksql-to-analyse-query-and-transform-data-in-kafka).<br />
Use [jcustenborder connector](https://github.com/jcustenborder/kafka-connect-twitter) and not [Eneco's connector](https://github.com/Eneco/kafka-connect-twitter#starting-kafka-connect-twitter), last one works only with **_kafka_ 0.10** !!!<br />

# Build _Twitter_ Connector
Clone source code from _Git_:<br /> 
`git clone https://github.com/jcustenborder/kafka-connect-twitter.git`

Get inside the new folder and build package with _Maven_ :<br />
`cd kafka-connect-twitter`<br />
`mvn clean package`<br />

Untar package:<br/>
`cd target`<br />
`tar -xvf kafka-connect-twitter-0.2-SNAPSHOT.tar.gz`<br\>

Copy .jar files from **/usr/share/kafka-connect/kafka-connect-twitter/** to **libs/** folder:<br />

> annotations-2.0.1.jar <br />
connect-utils-0.3.140.jar <br />
freemarker-2.3.25-incubating.jar <br />
guava-18.0.jar <br />
jackson-annotations-2.8.0.jar <br />
jackson-core-2.8.5.jar <br />
jackson-databind-2.8.5.jar <br />
javassist-3.19.0-GA.jar <br />
kafka-connect-twitter-0.2-SNAPSHOT.jar <br />
reflections-0.9.10.jar <br />
twitter4j-core-4.0.6.jar <br />
twitter4j-stream-4.0.6.jar <br />

# Test _Twitter_ Connector
We will test _Twitter_ Connector with _Kafka Connect_ in a standalone mode. First we will start a _Zookeeper_ server and a single _Kafka_ broker.<br/> 

## Start _Zookeeper_ 
Start _Zookeeper_ on localhost:2181 :<br />
`./bin/zookeeper-server-start.sh config/zookeeper.properties`

## Start _Kafka_ Broker
Start a single _kafka_ broker on localhost:9092 :<br />
`./bin/kafka-server-start.sh config/server.properties`


#### Twitter Access Tokens

Get/create _Twitter_ Access Token [here](https://apps.twitter.com/app/14818905/keys). Twitter App name: Ori-Kafka-Connect-Demo<br />

## Start _Kafka Connect_ in standalone mode
Start _Kafka Connect_ in standalone mode, based on [twitter-source-connector.properties](http://192.168.0.5/DataOps/twitter-source-connector/blob/master/config/twitter-source-connector.properties) connector config file:<br >
`./bin/connect-standalone.sh config/connect-standalone.properties config/twitter-source-connector.properties`

## Test
Test if topic **twitter-data** was created:<br />
`./bin/kafka-topics.sh --zookeeper localhost:2181 --list`

Test _Kafka Consumer_ topic output:<br \>
`./bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic twitter-data --from-beginning`

## Output
This is a data sample of twitter-data topic. The data consists of **schema** and **payload** key:value pairs. <Br/>
Better viewed on JSON [online parser](http://json.parser.online.fr/).<br \>
```perl
{"schema":{"type":"struct","fields":[{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"created_at"},{"type":"struct","fields":[{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"string","optional":true,"field":"screen_name"},{"type":"string","optional":true,"field":"location"},{"type":"boolean","optional":false,"field":"verified"},{"type":"int32","optional":false,"field":"friends_count"},{"type":"int32","optional":false,"field":"followers_count"},{"type":"int32","optional":false,"field":"statuses_count"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.User","field":"user"},{"type":"string","optional":true,"field":"text"},{"type":"string","optional":true,"field":"lang"},{"type":"boolean","optional":false,"field":"is_retweet"},{"type":"struct","fields":[{"type":"array","items":{"type":"struct","fields":[{"type":"string","optional":true,"field":"text"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Hashtag"},"optional":true,"field":"hashtags"},{"type":"array","items":{"type":"struct","fields":[{"type":"string","optional":true,"field":"display_url"},{"type":"string","optional":true,"field":"expanded_url"},{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"type"},{"type":"string","optional":true,"field":"url"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Medium"},"optional":true,"field":"media"},{"type":"array","items":{"type":"struct","fields":[{"type":"string","optional":true,"field":"display_url"},{"type":"string","optional":true,"field":"expanded_url"},{"type":"string","optional":true,"field":"url"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Url"},"optional":true,"field":"urls"},{"type":"array","items":{"type":"struct","fields":[{"type":"int64","optional":false,"field":"id"},{"type":"string","optional":true,"field":"name"},{"type":"string","optional":true,"field":"screen_name"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.UserMention"},"optional":true,"field":"user_mentions"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Entities","field":"entities"}],"optional":false,"name":"com.eneco.trading.kafka.connect.twitter.Tweet"},"payload":{"id":1052500156539658240,"created_at":"2018-10-17T10:02:46.000+0000","user":{"id":298914263,"name":"Jesús Sánchez","screen_name":"jesussp_","location":"México","verified":false,"friends_count":869,"followers_count":188,"statuses_count":1825},"text":"RT @javacodegeeks: How much faster is #Java 8? https://t.co/QMI2Fuj0Em","lang":"en","is_retweet":true,"entities":{"hashtags":[{"text":"Java"}],"media":[],"urls":[{"display_url":"buff.ly/2JH7qE5","expanded_url":"https://buff.ly/2JH7qE5","url":"https://t.co/QMI2Fuj0Em"}],"user_mentions":[{"id":150820027,"name":"Java Code Geeks","screen_name":"javacodegeeks"}]}}}
```