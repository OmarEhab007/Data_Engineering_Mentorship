package com.monitoring.device;

import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class App 
{    
    public static void main( String[] args )
    {
        ScheduledThreadPoolExecutor th = new ScheduledThreadPoolExecutor(10);
        
        try {
            Balancer b = new Balancer("test-topic3");
            th.scheduleAtFixedRate(b, 0, 1, TimeUnit.SECONDS);
            for (int i=0;i<10;i++){
                Server s = new Server(i,"test-topic4");
                th.scheduleAtFixedRate(s, 0, 100, TimeUnit.MILLISECONDS);
            }
        } catch (Exception e){
            e.printStackTrace(System.out);
        }
    }
}
