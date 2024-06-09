package com.monitoring.device;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.common.serialization.IntegerSerializer;
import org.apache.kafka.common.serialization.StringSerializer;

import org.apache.commons.lang3.RandomStringUtils;

import java.lang.Runnable;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

public class Balancer implements Runnable {
    
    String topic;
    Properties props;

    public Balancer(String topic){
        this.topic = topic;
        props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9092");
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,IntegerSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,StringSerializer.class.getName());
        props.put(ProducerConfig.ACKS_CONFIG,"1");
    }

    @Override
    public void run() {
        ThreadLocalRandom th = ThreadLocalRandom.current();
        String[] methods = {"GET","POST"};
        String[] statusCodes = {"200","401","403","404","500"};
        String[] extensions = {".pdf",".jpg",".png",".txt"};
        try {
            Producer<Integer,String> prod = new KafkaProducer<>(props);
            String ip = String.valueOf(th.nextInt(10, 254 + 1)) + "." + 
                        String.valueOf(th.nextInt(10, 254 + 1)) + "." +
                        String.valueOf(th.nextInt(10, 254 + 1)) + "." +
                        String.valueOf(th.nextInt(10, 254 + 1));
            String uid = String.valueOf(th.nextInt(101, 999 + 1));
            String dateTime = DateTimeFormatter.RFC_1123_DATE_TIME.format(LocalDateTime.now().atOffset(ZoneOffset.UTC));
            String method = methods[th.nextInt(0, 2)];
            String statusCode = statusCodes[th.nextInt(0, 5)];
            String filename = RandomStringUtils.randomAlphanumeric(32) + extensions[th.nextInt(0, 4)];
            String fileSize = String.valueOf(th.nextInt(120,65000000));
            String message = String.join(" ",ip,"-",uid,"["+dateTime+"]",method,filename,statusCode,fileSize);
            prod.send(new ProducerRecord<>(topic,99,message));
            prod.flush();
            prod.close();    
        } catch(Exception e) {
            e.printStackTrace(System.out);
        }
    }


}
