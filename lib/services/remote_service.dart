// import 'dart:convert';
// import 'package:arayanbulur/model/pharmacy.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
//
// class RemoteService {
//   static Future<List<Pharmacy>> getFetchPharmacy(String provinceName,
//       {String provinceDistrict}) async {
//     List<Pharmacy> _pharmacyList = [];
//     final _url = provinceDistrict == null
//         ? "http://35.232.28.33:3000/api/v1/pharmacies/duty/" +
//             provinceName +
//             "/"
//         : "http://35.232.28.33:3000/api/v1/pharmacies/duty/" +
//             provinceName +
//             "/" +
//             provinceDistrict;
//
//     String token = await FirebaseAuth.instance.currentUser.getIdToken();
//     http.Response response = await http.get(
//       Uri.parse(_url),
//       headers: {
//         'HttpHeaders.contentTypeHeader': 'application/json',
//         'Accept': 'application/json',
//         'charset': 'UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//     );
//     if (response.statusCode == 200) {
//       String source = Utf8Decoder().convert(
//         response.bodyBytes,
//       );
//       print(source);
//       final data = jsonDecode(
//         source,
//       );
//       for (Map i in data) {
//         _pharmacyList.add(
//           Pharmacy.fromJson(i),
//         );
//       }
//     }
//     return _pharmacyList;
//   }
// }
