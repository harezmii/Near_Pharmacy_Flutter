class Pharmacy {
  String pharmacyName;
  String pharmacyAddress;
  String pharmacyPhoneNumber;
  String pharmacyProvince;
  String pharmacyDistrict;
  String pharmacyLatLng;



  Pharmacy({this.pharmacyName, this.pharmacyAddress, this.pharmacyPhoneNumber,this.pharmacyProvince,this.pharmacyDistrict,this.pharmacyLatLng});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    pharmacyName = json['pharmacyName'];
    pharmacyAddress = json['pharmacyAddress'];
    pharmacyPhoneNumber = json['pharmacyPhoneNumber'];
    pharmacyProvince = json['pharmacyProvince'];
    pharmacyDistrict = json['pharmacyDistrict'];
    pharmacyLatLng = json['pharmacyLatLng'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pharmacyName'] = this.pharmacyName;
    data['pharmacyAddress'] = this.pharmacyAddress;
    data['pharmacyPhoneNumber'] = this.pharmacyPhoneNumber;
    data['pharmacyProvince'] = this.pharmacyProvince;
    data['pharmacyDistrict'] = this.pharmacyDistrict;
    data['pharmacyLatLng'] = this.pharmacyLatLng;

    return data;
  }
}
