class User {
  int value;
  String displayName;
  String givenName;
  String surname;
  String userPrincipalName;
  String mobileNumber;
  String email;
  String id;

  User({
    required this.value,
    required this.displayName,
    required this.givenName,
    required this.surname,
    required this.userPrincipalName,
    required this.mobileNumber,
    required this.email,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        value: responseData['value'],
        displayName: responseData['displayName'],
        givenName: responseData['givenName'],
        surname: responseData['surname'],
        userPrincipalName: responseData['userPrincipalName'],
        mobileNumber: responseData['mobileNumber'],
        email: responseData['email'],
        id: responseData['id']);
  }
}
