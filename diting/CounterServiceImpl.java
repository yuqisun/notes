@Override
    public List<Point> getCounter(String appName, int precision) {
        SimpleDateFormat sdf = new SimpleDateFormat("MM.dd.yyyy HH:mm:ss");
        int prec = precision;
        System.out.println("------------- " + prec + " -------------");
        Map<String, String> result = CONN.hgetAll("count:" + prec + ":hits:etf");

        List<Point> points = new ArrayList<>();
        for(Map.Entry<String, String> entry : result.entrySet()) {
            System.out.println("key: " + entry.getKey() + ", value: " + entry.getValue());
            Point point = new Point();
            Date date = new Date(Long.valueOf(entry.getKey())*1000L);
            point.setX(sdf.format(date));
            point.setValue(entry.getValue());
            points.add(point);
        }

        System.out.println(points);
        return points;
    }
