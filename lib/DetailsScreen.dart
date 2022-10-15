import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo/utils/getDate.dart';
import 'package:meteo/utils/getTemperatureAssets.dart';

class PageDetails extends StatelessWidget {
  const PageDetails({super.key, required this.info, required this.city});
  final Map<String, dynamic> info;
  final String city;
  String getHour(int timestamp){
    final datetimeMeteo = DateTime.fromMillisecondsSinceEpoch(timestamp*1000);

    return DateFormat('HH:mm').format(datetimeMeteo) as String;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${getDate(info?['dt'] as int)} à ${city}'),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,

            child: Column(

                children: [
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${info?['temp']?['day']}°C', style: TextStyle(
                          fontSize: 40.0
                      )),
                      Hero(
                          tag: info['dt'],
                          child: Container(
                            height: 100.0,
                            child: Image.asset(getTemperatureAssets(info?['weather']?[0]?['icon'] as String)?['icon'], height: 80.0,),
                          )
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0,0.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Minimale', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),),
                                Text('${info?['temp']?['min']}°C')
                              ],
                            ),
                            Column(
                              children: [
                                Text('Maximale', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),),
                                Text('${info?['temp']?['max']}°C')
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Lever du soleil', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),),
                                Text(getHour(info['sunrise']))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Coucher du soleil', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),),
                                Text(getHour(info['sunset']))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Vitesse des vents', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),),
                                Text('${info?['wind_speed']} km/h')
                              ],
                            ),
                            Column(
                              children: [
                                Text('Humidité', style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),),
                                Text('${info?['humidity']}%'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]
            )),
      ),
    );
  }
}