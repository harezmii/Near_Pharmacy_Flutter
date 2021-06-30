import 'dart:convert';
import 'package:arayanbulur/model/pharmacy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String _provinceName;

  Home(this._provinceName);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  GoogleMapController _googleMapController;
  LatLng _initialLocation = LatLng(39.4226593, 35.90290986);

  // ignore: deprecated_member_use
  List<Marker> _marker = new List<Marker>();
  List<Pharmacy> _pharmacyList = [];

  List<String> _districtList = [];
  String _selectProvinceName = "";
  String _selectDistrictName = "";

  bool _isMarkerDetail = false;
  bool _isOpen = false;
  Widget _getMarkerDetail;

  List<String> _provinceList = [
    "adana",
    "adiyaman",
    "afyonkarahisar",
    "agri",
    "amasya",
    "ankara",
    "antalya",
    "artvin",
    "aydin",
    "balikesir",
    "bilecik",
    "bingol",
    "bitlis",
    "bolu",
    "burdur",
    "bursa",
    "canakkale",
    "cankiri",
    "corum",
    "denizli",
    //"diyarbakir",
    "edirne",
    "elazig",
    "erzincan",
    "erzurum",
    "eskisehir",
    "gaziantep",
    "giresun",
    "gumushane",
    "hakkari",
    "hatay",
    "isparta",
    "mersin",
    "istanbul",
    "izmir",
    "kars",
    "kastamonu",
    "kayseri",
    "kirklareli",
    "kirsehir",
    "kocaeli",
    "konya",
    "kutahya",
    "malatya",
    "manisa",
    "kahramanmaras",
    "mardin",
    "mugla",
    "mus",
    "nevsehir",
    "nigde",
    "ordu",
    "rize",
    "sakarya",
    "samsun",
    "siirt",
    "sinop",
    "sivas",
    "tekirdag",
    "tokat",
    "trabzon",
    "tunceli",
    "sanliurfa",
    "usak",
    "van",
    "yozgat",
    "zonguldak",
    "aksaray",
    "bayburt",
    "karaman",
    "kirikkale",
    "batman",
    "sirnak",
    "bartin",
    "ardahan",
    "igdir",
    "yalova",
    "karabuk",
    "kilis",
    "osmaniye",
    "duzce",
  ];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initLocation();
  }

  getFetchData(String provinceName, {String provinceDistrict}) async {
    final _url = provinceDistrict == null
        ? "http://35.225.43.160:3000/api/v1/pharmacies/duty/" +
            provinceName +
            "/"
        : "http://35.225.43.160:3000/api/v1/pharmacies/duty/" +
            provinceName +
            "/" +
            provinceDistrict;

    String token = await FirebaseAuth.instance.currentUser.getIdToken();

    http.Response response = await http.get(
      Uri.parse(_url),
      headers: {
        'Accept': 'application/json',
        'charset': 'UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(
        response.bodyBytes,
      );
      final data = jsonDecode(
        source,
      );
      setState(
        () {
          for (Map i in data) {
            _pharmacyList.add(
              Pharmacy.fromJson(i),
            );
          }
        },
      );
    }

    return _pharmacyList;
  }

  initLocation() async {
    var status = await Location.instance.requestPermission();
    await DotEnv().load(fileName: ".env");
    print("Fetch Data");
    setState(() {
      setMarkerPharmacy(this.widget._provinceName);
    });
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _initMap(GoogleMapController controller) async {
    LocationData locationData = await Location.instance.getLocation();

    _googleMapController = controller;
    _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            locationData.latitude,
            locationData.longitude,
          ),
          zoom: 8.0,
        ),
      ),
    );
  }

  Future<double> getLocationDistanceKm(double lat, double lng) async {
    LocationData _locationData = await Location.instance.getLocation();
    return _coordinateDistance(
        _locationData.latitude, _locationData.longitude, lat, lng);
  }

  getDistrictList() {
    for (Pharmacy pharmacy in _pharmacyList) {
      _districtList.add(pharmacy.pharmacyDistrict);
    }
    setState(
      () {
        _districtList = _districtList.toSet().toList();
      },
    );
  }

  setMarkerPharmacy(String provinceName, {String provinceDistrict}) async {
    List<Pharmacy> data = await getFetchData(
      provinceName,
      provinceDistrict: provinceDistrict,
    );
    getDistrictList();
  print(data[0].pharmacyLatLng);
    data.asMap().forEach(
      (index, value) {
        double lat;
        double lng;
        if (value.pharmacyLatLng != "") {
          String latLng = value.pharmacyLatLng.replaceAll("(", "");
          lat = double.parse(latLng.split(",")[0]);
          lng = double.parse(latLng.split(",")[1]);
          setState(
            () {
              print("Marker Ekleniyor");
              _marker.add(
                Marker(
                  infoWindow: InfoWindow(
                      title: value.pharmacyName,
                      snippet: value.pharmacyPhoneNumber),
                  markerId: MarkerId(
                    value.pharmacyAddress,
                  ),
                  position: LatLng(
                    lat,
                    lng,
                  ),
                  onTap: () async {
                    double km = await getLocationDistanceKm(lat, lng);
                    double resultKm = km + 3.0;
                    setState(
                      () {
                        _isMarkerDetail = true;
                        _getMarkerDetail = getMarkerDetail(
                          value.pharmacyName,
                          value.pharmacyProvince.toUpperCase() +
                              "/" +
                              value.pharmacyDistrict,
                          value.pharmacyPhoneNumber,
                          resultKm.toStringAsFixed(2),
                          lat,
                          lng,
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget getMarkerDetail(String pharmacyName, String pharmacyAddress,
      String pharmacyPhoneNumber, String km, double lat, double lng) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "images/pharmacy.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          pharmacyName,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          pharmacyAddress,
                          style: TextStyle(
                            color: Colors.black87,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Konuma $km uzaklıkta ",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 8,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            final url =
                                "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
                            if (await canLaunch(url) != null) {
                              await launch(url);
                            } else {
                              print("Hata Var");
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.map,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: Colors.black87,
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            // String splitNumber = pharmacyPhoneNumber.length > 15
                            //     ? pharmacyPhoneNumber.substring(0, 15).trim()
                            //     : pharmacyPhoneNumber;
                            String telNumber = "tel:+9" +
                                pharmacyPhoneNumber.replaceAll(" ", "");

                            if (await canLaunch(telNumber)) {
                              await launch(telNumber);
                            } else {
                              print(
                                "Aranamadi",
                              );
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.call,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _googleMapController.setMapStyle("[]");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onTap: (value) {
                if (value == null) {
                } else {
                  setState(
                    () {
                      _isMarkerDetail = false;
                    },
                  );
                }
              },
              mapToolbarEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: _initMap,
              initialCameraPosition: CameraPosition(
                target: _initialLocation,
                zoom: 6.0,
              ),
              markers: Set.of(
                _marker,
              ),
            ),

            // My Location
            Positioned(
              bottom: 120,
              right: 10,
              child: Container(
                height: MediaQuery.of(context).size.height / 16,
                width: MediaQuery.of(context).size.width / 8,
                color: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.location_on_sharp),
                  onPressed: () async {
                    print("Location");
                    LocationData locationData =
                        await Location.instance.getLocation();
                    _googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(
                            locationData.latitude,
                            locationData.longitude,
                          ),
                          zoom: 15.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

           _isOpen == false ? Positioned(
              top: 20,
              left: -20,
              child: Container(
                height: 50,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      8.0,
                    ),
                    bottomRight: Radius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 14.0,
                    top: 2.0,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isOpen = true;
                      });
                    },
                    icon: Icon(
                      Icons.apps_sharp,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ) : Container(),

            _isOpen == true ? Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onHorizontalDragEnd: (e) {
                  setState(() {
                    _isOpen = false;
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8.0,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      2.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  8.0,
                                ),
                                bottomLeft: Radius.circular(
                                  8.0,
                                ),
                              ),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Container(
                                margin: EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Text(
                                  "İller",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              icon: Icon(
                                Icons.arrow_circle_down_sharp,
                                color: Colors.white,
                              ),
                              items: _provinceList.map(
                                (String e) {
                                  return DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  );
                                },
                              ).toList(),
                              onChanged: (value) async {
                                setState(
                                  () {
                                    _pharmacyList = [];
                                    _selectProvinceName = value;
                                    _marker = [];
                                    setMarkerPharmacy(_selectProvinceName);
                                    _districtList = [];
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                  8.0,
                                ),
                                bottomRight: Radius.circular(
                                  8.0,
                                ),
                              ),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Container(
                                margin: EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Text(
                                  "İlçeler",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              icon: Icon(
                                Icons.arrow_circle_down_sharp,
                                color: Colors.white,
                              ),
                              items: _districtList.map(
                                (String e) {
                                  return DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    _selectDistrictName = value;
                                    _marker = [];
                                    setMarkerPharmacy(_selectProvinceName,
                                        provinceDistrict: _selectDistrictName);
                                    _pharmacyList = [];
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ) : Container(),

            _isMarkerDetail == true ? _getMarkerDetail : Container(),
          ],
        ),
      ),
    );
  }
}
