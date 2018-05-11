@Test
    public void get60sCounterTest() {
        Jedis conn = new Jedis("localhost");
        int prec = 60;
        System.out.println("------------- " + prec + " -------------");
        Map<String, String> result = conn.hgetAll("count:" + prec + ":hits:etf");

        List<Point> points = new ArrayList<>();
        for(Map.Entry<String, String> entry : result.entrySet()) {
            System.out.println("key: " + entry.getKey() + ", value: " + entry.getValue());
            Point point = new Point();
            point.setX(entry.getKey());
            point.setValue(entry.getValue());
            points.add(point);
        }

        System.out.println(points);
    }

    @Test
    public void testTime() {
//        key: 1525935600, value: 357
//        key: 1525939200, value: 4705
        SimpleDateFormat sdf = new SimpleDateFormat("MM.dd.yyyy HH:mm:ss");
        System.out.println(sdf.format(new Date(1525939440*1000L)));
        System.out.println(new Date(1525939440*1000L));
    }
