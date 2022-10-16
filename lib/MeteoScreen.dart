import 'package:intl/date_symbol_data_local.dart';
import 'package:meteo/utils/getDate.dart';
import 'package:meteo/DetailsScreen.dart';
import 'package:meteo/utils/getTemperatureAssets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meteo/constants/WeatherApiKey.dart';
import 'package:meteo/models/WeatherModel.dart';


class PageMeteo extends StatefulWidget {
  const PageMeteo({super.key, required this.title, required this.lat, required this.lng, required this.city});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final  String lat;
  final String city;
  final String lng;

  @override
  State<PageMeteo> createState() => _MyHomePageState(
    lat: this.lat,
    lng: this.lng,
    city: this.city,

  );
}

class _MyHomePageState extends State<PageMeteo> with SingleTickerProviderStateMixin {
  int colorBtn = 0xFF000000;
  final String lat;
  String city;
  String lng;
  late Future<WeatherForecast> response;
  _MyHomePageState({
    required this.lat,
    required this.lng,
    required this.city,
  });



  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    response = fetchMeteo();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<WeatherForecast> fetchMeteo() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/3.0/onecall?lat=${lat}&lon=${lng}&appid=${apiKey}&lang=fr&units=metric&exclude=minutely,alerts,hourly'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return WeatherForecast.fromJson(parsed as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load');
    }
  }

  Widget _buildListItems() {
    return FutureBuilder<WeatherForecast>(
        future: response,
        builder: (context, snapshot) {
          print(snapshot.error);
          if (snapshot.hasData) {
            return ListView(
              children: [
                for(var child in snapshot.data?.days ?? [])
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PageDetails(info: child, city: city),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color(getTemperatureAssets(child.icon)?['backgroundColor'])
                      ),
                      height: 150,
                      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      child: Row(
                        children: [
                          Padding(padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              Hero(
                                  tag: child.dt,
                                  child: Image.asset(getTemperatureAssets(child.icon as String)?['icon'], height: 100.0, width: 100.0,)
                              ),
                            ],),
                          ),
                          Padding(padding: EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(getDate(child.dt as int),
                                    style: TextStyle(color: Color(getTemperatureAssets(child.icon as String)?['color']),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Center(child: Text((child.temperature.toString()) + "°",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Color(getTemperatureAssets(child.icon)?['color'])
                                        ),
                                      ),)
                                      ,
                                    ],
                                  )

                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  )],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });

  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo à ${city}'),
      ),
      body: _buildListItems(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}