import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:meteo/constants/GoogleApiKey.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:meteo/MeteoScreen.dart';
import 'package:flash/flash.dart';

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

class PageChooseCity extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _MyAppState extends State<PageChooseCity> {
  final _controller = TextEditingController();
  String city = '';
  String lng = '';
  String lat = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getPlaceDetailWithLatLng  (Prediction prediction) {
  print(prediction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("Choissisez une ville"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GooglePlaceAutoCompleteTextField(
                    textEditingController: _controller,
                    googleAPIKey: kGoogleApiKey,
                    inputDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Rechercher une ville',
                        hintText: "Rechercher une ville"),
                    debounceTime: 800,
                    countries: ["in", "fr"],
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (prediction) => {
                      setState(() {
                        city = prediction.description as String;
                        lng = prediction.lng as String;
                        lat = prediction.lat as String;
                      })
                    },
                    itmClick: (prediction) {
                      _controller.text = prediction.description as String;

                      _controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: (prediction.description as String).length));
                    }
                  // default 600 ms ,
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  if(city != '' && lat != '' && lng != '' ){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageMeteo(
                            title: 'Météo à ${city}',
                            lng: lng,
                            lat: lat,
                            city: city
                        ),
                      ),
                    );
                  } else {
                    showFlash(
                        context: context,
                        duration: Duration(seconds: 3),
                        builder: (_, controller){
                          return Flash(controller: controller,
                              backgroundColor: Colors.red,
                              position: FlashPosition.top,
                              behavior: FlashBehavior.fixed,
                              child: FlashBar(
                                content: Text('Choissisez une ville avant de continuer',
                                  style: TextStyle(color: Color(0xFFFFFFFF)),),
                              )
                          );
                        });
                  }

                },
                child: Text("Rechercher une ville"),
              ),
            ],
          )),
    );
  }
}