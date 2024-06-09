package com.monitoring.device;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.IntegerSerializer;
import org.apache.kafka.common.serialization.StringSerializer;

import java.util.Properties;
import java.lang.Runnable;
import java.util.concurrent.ThreadLocalRandom;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.time.ZoneOffset;


public class Server implements Runnable{
    
    private String topic;
    private Properties props;
    private int id;

    public Server(int id,String topic) {
        this.id = id;
        props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9092");
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,IntegerSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,StringSerializer.class.getName());
        props.put(ProducerConfig.ACKS_CONFIG,"1");

        this.topic = topic;
    }
    @Override
    public void run() {
        try {
            Producer<Integer,String> prod = new KafkaProducer<>(props);
            int cpu = ThreadLocalRandom.current().nextInt(5, 100 + 1);
            int mem = ThreadLocalRandom.current().nextInt(10, 100 + 1);
            int disk = ThreadLocalRandom.current().nextInt(1, 100 + 1);
            DateTimeFormatter.RFC_1123_DATE_TIME.format(LocalDateTime.now().atOffset(ZoneOffset.UTC));
            String message = String.join(",","id: "+String.valueOf(id), "cpu: " + String.valueOf(cpu),
                    "mem: "+String.valueOf(mem), "disk: "+String.valueOf(disk));
            prod.send(new ProducerRecord<>(topic,id,message));
            prod.flush();
            prod.close();    
        } catch(Exception e) {
            e.printStackTrace(System.out);
        }
    }
}
