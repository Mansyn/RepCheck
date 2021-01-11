class PlaceResponse {
  String streetNumber;
  String street;
  String city;
  String state;
  String zipCode;

  PlaceResponse({
    this.streetNumber,
    this.street,
    this.city,
    this.state,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}
