```
public interface CounterService {
    void updateCounter(String appName);
    void updateCounter(String appName, Integer count);
    void updateCounter(String appName, Integer count, Long now);
    void updateCounter(String appName, Integer count, String now);
    void updateCounter(String appName, Integer count, Date now);
    void updateCounter(String appName, int count, long now);

}

public class CounterServiceImpl implements CounterService {
    private static final Jedis CONN = new Jedis("localhost");
    private static final int[] PRECISION = new int[]{60, 300, 1800, 3600, 18000, 86400};

    @Override
    public void updateCounter(String appName) {

    }

    @Override
    public void updateCounter(String appName, Integer count) {

    }

    @Override
    public void updateCounter(String appName, Integer count, Long now) {

    }

    @Override
    public void updateCounter(String appName, Integer count, String now) {

    }

    @Override
    public void updateCounter(String appName, Integer count, Date now) {

    }

    @Override
    public void updateCounter(String appName, int count, long now) {
        appName = appName.toLowerCase();
        System.out.println("name: " + appName + ", count: " + count + ", now: " + now);

        Transaction transaction = CONN.multi();
        for(int prec : PRECISION) {
            long pnow = (now / prec) * prec;
            String hash = String.valueOf(prec) + ":hits:" + appName;    //60:hits:etf

            System.out.println("hash: " + hash);
            transaction.zadd("known:", 0, hash);
            transaction.hincrBy("count:" + hash, String.valueOf(pnow), count);
        }
        transaction.exec();
    }

}


public class CounterServiceTest {
    @Test
    public void testUpdateCounter() {
        CounterService counterService = new CounterServiceImpl();
        long now = System.currentTimeMillis()/1000;
        /*for(int i=0; i<100; i++) {
            counterService.updateCounter("etf", (int)(Math.random()*100), now+i*10);
        }*/
        counterService.updateCounter("etf", 4, now);
    }

    @Test
    public void getCounter() {
        Jedis conn = new Jedis("localhost");
        for(int prec : new int[]{60, 300, 1800, 3600, 18000, 86400}) {
            System.out.println("------------- " + prec + " -------------");
            Map<String, String> result = conn.hgetAll("count:" + prec + ":hits:etf");
            for(Map.Entry<String, String> entry : result.entrySet()) {
                System.out.println("key: " + entry.getKey() + ", value: " + entry.getValue());
            }

            JSONObject json = new JSONObject(result);
            System.out.println(json.toString());
        }

    }

    @Test
    public void testTime() {
//        key: 1525935600, value: 357
//        key: 1525939200, value: 4705
        System.out.println(new Date(1525935600*1000L));
        System.out.println(new Date(1525939200*1000L));
    }

    @Test
    public void clearCounter() {
        Jedis conn = new Jedis("localhost");
        Set<String> counterNames = conn.zrange("known:", 0, -1);
        for(String name : counterNames) {
            System.out.println(" --- Counter name: " + name + " ---");
            Set<String> keys = conn.hkeys("count:"+ name);
            for(String key : keys) {
                System.out.println("key: " + key);
                conn.hdel("count:"+ name, key);
            }
        }
    }
}



