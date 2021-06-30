import 'package:arayanbulur/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(
        seconds: 3,
      ),
      () async {
        String _provinceName = await getGeo();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Home(_provinceName);
            },
          ),
        );
      },
    );
  }

  getGeo() async {
    print("Burada");
    String city;

    Map<String,String> turkishCharacter = {
      "ç" : "c",
      "Ç" : "C",
      "ş" : "s",
      "Ş" : "S",
      "ö" : "o",
      "Ö" : "O",
      "ü" : "u",
      "Ü" : "U",
      "ğ" : "g",
      "Ğ" : "G",
      "ı" : "i",
      "I" : "İ",
    };

    LocationData locationData = await Location.instance.getLocation();
    Address address = await GeoCode().reverseGeocoding(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );
    print(address.region);
    if(address.region.contains(',')) {
      city = address.region.split(',')[1].trim().toLowerCase();
      for(int i=0 ; i < city.length ; i++) {
          if(turkishCharacter[city[i]] != null) {
            city = city.replaceAll(city[i], turkishCharacter[city[i]]);
          }
          print("Hiç Yok");
      }
    } else {
      city = address.region.trim().toLowerCase();
    }
    print("ŞŞ");
    return city;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Image.asset(
              "images/pharmacy.jpg",
              fit: BoxFit.cover,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Merhaba !",
              style: TextStyle(
                letterSpacing: 1.0,
                fontSize: 32,
                color: Colors.grey,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Arayan",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
                TextSpan(
                  text: "Bulur",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Loading",
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
