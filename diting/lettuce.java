@Override
    public void updateCounter(String appName, long now, int count) {
        LOGGER.info("app name: {}, now: {}, count: {}", appName, now, count);

        RedisAsyncCommands<String, String> asyncCommands = masterSlaveConnection.async();
        List<RedisFuture<Long>> futures = new ArrayList();

        appName = appName.toLowerCase();
        futures.add(asyncCommands.sadd("app-name", appName));
        for(int prec : PRECISION) {
            long pnow = (now / 1000 / prec) * prec;
            String hash = String.valueOf(prec) + ":hits:" + appName;    //60:hits:etf

            LOGGER.info("hash: " + hash);
            futures.add(asyncCommands.zadd("known:" + appName, 0, hash));
            futures.add(asyncCommands.hincrby("count:" + hash, String.valueOf(pnow), count));
        }
        LettuceFutures.awaitAll(1, TimeUnit.MINUTES, futures.toArray(new RedisFuture[futures.size()]));
    }

    @Override
    public List<Point> getCounter(String appName, int precision) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss");
        RedisCommands<String, String> syncCommands = masterSlaveConnection.sync();
        Map<String, String> result = syncCommands.hgetall("count:" + precision + ":hits:" + appName);

        List<Point> points = new ArrayList<>();
        for(Map.Entry<String, String> entry : result.entrySet()) {
            LOGGER.info("key: {}, value: {}", entry.getKey(), entry.getValue());
            Point point = new Point();
            Date date = new Date(Long.valueOf(entry.getKey())*1000L);
            point.setX(sdf.format(date));
            point.setValue(entry.getValue());
            points.add(point);
        }

        LOGGER.info("Point size: {}", points.size());
        return points;
    }
