class Customer {
  String uid;
  String name;
  int phoneNumber;
  int phoneNumberAdditional;
  String cityID;
  String address;
  String businesID;
  String cityName;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Customer(
      {this.uid,
      this.name,
      this.phoneNumber,
      this.phoneNumberAdditional,
      this.cityID,
      this.address,
      this.businesID,
      this.isArchived,
      this.deleteDate,
      this.deleteUser,
      this.cityName});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'phoneNumberAdditional': phoneNumberAdditional,
        'cityID': cityID,
        'address': address,
        'businesID': businesID,
        'isArchived': isArchived
      };
}
