https://docs.anychart.com/Stock_Charts/Scroller

```
TimeZone timeZoneNY = TimeZone.getTimeZone("America/New_York");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss", Locale.US);
        sdf.setTimeZone(timeZoneNY);
        int prec = precision;
        System.out.println("------------- " + prec + " -------------");
        Map<String, String> result = CONN.hgetAll("count:" + prec + ":hits:etf");

        List<Point> points = new ArrayList<>();
        for(Map.Entry<String, String> entry : result.entrySet()) {
            System.out.println("key: " + entry.getKey() + ", value: " + entry.getValue());
            Point point = new Point();
            Date date = new Date(Long.valueOf(entry.getKey())*1000L+5000L);
            //point.setX(sdf.format(date));
            System.out.println(sdf.format(date));
            point.setX(sdf.format(date));
            point.setValue(entry.getValue());
            points.add(point);
        }

        System.out.println(points);
        return points;
        
        
function getData(){
            var data;
            $.ajax({
                async: false,
                cache: false,
                url: 'http://localhost:8080/getCounter/300',
                dataType: 'text',
                success: function(resp) {
                    var arr=new Array();
                    //console.log('---------  1  ----------');
                    //console.log(resp);
                    //console.log(JSON.parse(resp));
                    data=JSON.parse(resp);
                    console.log(data);
                    for(var i=0;i<data.length;i++) {
                        console.log(data[i].x);
                        var tmp=new Object();
                        var xValue=data[i].x.split('.');
                        tmp.x=Date.UTC(xValue[0], xValue[1]-1, xValue[2], xValue[3], xValue[4], xValue[5]);
                        tmp.value=data[i].value;
                        arr[i]=tmp;
                    }
                    console.log('---------  1  ----------');
                    console.log(arr);
                    data=arr;
                }

            });
            //data = [{'x':'05.04.2010 17.31.50', 'value':7},{'x':'05.04.2010 17.30.05', 'value':2}];
            console.log('---------  2  ----------');
            //data = [{"x":1526028060000, "value":7},{"x":Date.UTC(2018, 01, 11, 04, 41, 05), "value":2}];
            console.log(data);
            return data;
```

