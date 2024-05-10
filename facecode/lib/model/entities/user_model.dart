
class UserModel {
  String? id;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? country;
  String? state;
  String? city;
  String? jobTitle;
  String? imageUrl;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.jobTitle,
      required this.lastName,
      required this.phone,
      required this.city,
      required this.country,
      required this.state,
      required this.imageUrl});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            state: json['state'],
            country: json['country'],
            city: json['city'],
            email: json['email'],
            firstName: json['firstName'],
            lastName: json['lastName'],
            id: json['id'],
            jobTitle: json['jobTitle'],
            phone: json['phone'],
            imageUrl: json['imageUrl']);

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "id": id,
      "jobTitle": jobTitle,
      "phone": phone,
      "city": city,
      "country": country,
      "state": state,
      "imageUrl": imageUrl,
    };
  }
}
