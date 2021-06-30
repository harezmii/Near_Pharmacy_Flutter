// import 'package:arayanbulur/model/pharmacy.dart';
// import 'package:arayanbulur/services/remote_service.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'dart:math' show cos, sqrt, asin;
//
// import 'package:url_launcher/url_launcher.dart';
//
// class HomeController {
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//   // ignore: deprecated_member_use
//   var pharmacyList = List<Pharmacy>().obs;
//
//   // ignore: deprecated_member_use
//   var districtList = List<String>().obs;
//
//   // ignore: deprecated_member_use
//   var marker = new List<Marker>().obs;
//   Widget _getMarkerDetail;
//
//   fetchPharmacies(String provinceName, {String districtName}) async {
//     var data = await RemoteService.getFetchPharmacy(provinceName);
//     pharmacyList.value = data;
//     print("Boyut : " + pharmacyList.length.toString());
//   }
//
//   getDistrictList() {
//     for (Pharmacy pharmacy in pharmacyList) {
//       districtList.add(pharmacy.pharmacyDistrict);
//     }
//     districtList = districtList.toSet().toList();
//   }
//
//   double _coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
//
//   Future<double> getLocationDistanceKm(double lat, double lng) async {
//     LocationData _locationData = await Location.instance.getLocation();
//     return _coordinateDistance(
//         _locationData.latitude, _locationData.longitude, lat, lng);
//   }
//
//   Widget getMarkerDetail(String pharmacyName, String pharmacyAddress,
//       String pharmacyPhoneNumber, String km, double lat, double lng) {
//     return Positioned(
//       bottom: 20,
//       left: 20,
//       right: 10,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(
//             10.0,
//           ),
//         ),
//         height: 80,
//         child: IntrinsicHeight(
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                         "images/pharmacy.jpg",
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 flex: 3,
//               ),
//               Expanded(
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 4,
//                         child: Text(
//                           pharmacyName,
//                           style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 1.0,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: Text(
//                           pharmacyAddress,
//                           style: TextStyle(
//                             color: Colors.black87,
//                             letterSpacing: 1.0,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 4,
//                         child: Text(
//                           "Konuma $km uzaklıkta ",
//                           style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 1.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 flex: 8,
//               ),
//               Expanded(
//                 child: Container(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: GestureDetector(
//                           onTap: () async {
//                             final url =
//                                 "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
//                             if (await canLaunch(url) != null) {
//                               await launch(url);
//                             } else {
//                               print("Hata Var");
//                             }
//                           },
//                           child: Container(
//                             child: Icon(
//                               Icons.map,
//                               color: Colors.blue.shade700,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Divider(
//                         height: 1.0,
//                         color: Colors.black87,
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: GestureDetector(
//                           onTap: () async {
//                             // String splitNumber = pharmacyPhoneNumber.length > 15
//                             //     ? pharmacyPhoneNumber.substring(0, 15).trim()
//                             //     : pharmacyPhoneNumber;
//                             String telNumber = "tel:+9" +
//                                 pharmacyPhoneNumber.replaceAll(" ", "");
//
//                             if (await canLaunch(telNumber)) {
//                               await launch(telNumber);
//                             } else {
//                               print(
//                                 "Aranamadi",
//                               );
//                             }
//                           },
//                           child: Container(
//                             child: Icon(
//                               Icons.call,
//                               color: Colors.green.shade700,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 flex: 2,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   setMarkerPharmacy(String provinceName, {String provinceDistrict}) async {
//     getDistrictList();
//
//     pharmacyList.asMap().forEach(
//       (index, value) {
//         double lat;
//         double lng;
//         if (value.pharmacyLatLng != "") {
//           String latLng = value.pharmacyLatLng.replaceAll("(", "");
//           lat = double.parse(latLng.split(",")[0]);
//           lng = double.parse(latLng.split(",")[1]);
//
//           marker.add(
//             Marker(
//               infoWindow: InfoWindow(
//                   title: value.pharmacyName,
//                   snippet: value.pharmacyPhoneNumber),
//               markerId: MarkerId(
//                 value.pharmacyAddress,
//               ),
//               position: LatLng(
//                 lat,
//                 lng,
//               ),
//               onTap: () async {
//                 double km = await getLocationDistanceKm(lat, lng);
//                 double resultKm = km + 3.0;
//
//                 _getMarkerDetail = getMarkerDetail(
//                   value.pharmacyName,
//                   value.pharmacyProvince.toUpperCase() +
//                       "/" +
//                       value.pharmacyDistrict,
//                   value.pharmacyPhoneNumber,
//                   resultKm.toStringAsFixed(2),
//                   lat,
//                   lng,
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }
