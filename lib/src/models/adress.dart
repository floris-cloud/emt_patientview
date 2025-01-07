class Address {
  String street;
  String houseNumber;
  String zipCode;
  String city;

  Address(this.street, this.houseNumber, this.zipCode, this.city);


  Address.fromJson(Map<String, dynamic> json)
      : street = json['strasse'],
        houseNumber = json['hausnummer'],
        zipCode = json['plz'],
        city = json['ort'];

  Map<String, dynamic> toJson() => {
    'strasse': street,
    'hausnummer': houseNumber,
    'plz': zipCode,
    'ort': city,
  };
}
