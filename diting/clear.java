package pers.xyzz.diting.config;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import pers.xyzz.diting.service.CounterService;

/**
 * Created by ys67458 on 5/23/2018.
 */
@Configuration
public class ClearCounterThread {
    @Autowired
    private CounterService service;

    public ClearCounterThread() {
        Calendar calendar = Calendar.getInstance();
        TimeZone usTimeZone = TimeZone.getTimeZone("America/New_York");
        calendar.setTimeZone(usTimeZone);
        calendar.set(Calendar.HOUR_OF_DAY, 13); // 控制时
        calendar.set(Calendar.MINUTE, 30);       // 控制分
        calendar.set(Calendar.SECOND, 0);       // 控制秒

        Date time = calendar.getTime();         // 得出执行任务的时间,此处为今天的12：00：00

        Timer timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask() {
            public void run() {
                System.out.println("-------设定要指定任务--------");
                service.clearExpiredCounter();
            }
        }, time, 1000 * 60 * 60 * 24);
    }
}
