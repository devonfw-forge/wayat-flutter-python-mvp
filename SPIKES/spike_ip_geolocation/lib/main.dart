import 'package:flutter/material.dart';
import 'package:ip_geolocation_api/ip_geolocation_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GeolocationData data = GeolocationData(
      country: "Ukraine",
      countryCode: "UA",
      timezone: "Europe/Kyiv",
      ip: "2.155.76.101",
      lat: 50.450001,
      lon: 30.523333);

  GeolocationData geolocationData;

  @override
  void initState() {
    super.initState();
    this.getIp();
  }

  Future<void> getIp() async {
    geolocationData = await GeolocationAPI.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Text(data.ip),
                  Text(data.lat.toString()),
                  Text(data.lon.toString()),
                  Text(data.country),
                  Text(data.countryCode),
                  Text(data.timezone),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 20))
                ],
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      data = geolocationData;
                    });
                  },
                  child: Text("Get Location Data"))
            ],
          ),
        ),
      ),
    );
  }
}
