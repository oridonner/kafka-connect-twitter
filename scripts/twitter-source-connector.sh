echo '{"name": "source-twitter-distributed-1", "config":{"connector.class":"com.eneco.trading.kafka.connect.twitter.TwitterSourceConnector","tasks.max":"1","topic":"twitter-data","key.converter":"org.apache.kafka.connect.json.JsonConverter","key.converter.schemas.enable":"true","value.converter":"org.apache.kafka.connect.json.JsonConverter","value.converter.schemas.enable":"true","twitter.consumerkey":"WyBAPqB21h196UyENZATSnL3F","twitter.consumersecret":"jQtSGi0tynigU51EkSfCNahqrBkHE18cH0xU2FttVzTKpNbcJO","twitter.token":"908270057641463809-iju88vZOOTl2hiROMRA1XGLG1CnQPKI","twitter.secret":"r4L9oXix5wqoAD5GNIMtjRJOHuVO65mWLynhmmnD7sOW1","track.terms":"programming,java,kafka,scala","language":"en"}}' | \
curl -X POST -d @- http://localhost:8083/connectors \
--header "Content-Type:application/json"