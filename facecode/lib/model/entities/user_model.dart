class UserModel {
  String? id;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? region;
  String? jobTitle;
  String? imageUrl;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.jobTitle,
      required this.lastName,
      required this.phone,
      required this.region,
      required this.imageUrl});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          email: json['email'],
          firstName: json['firstName'],
          lastName: json['lastName'],
          id: json['id'],
          jobTitle: json['jobTitle'],
          phone: json['phone'],
          region: json['region'],
          imageUrl: json['imageUrl']
        );

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "id": id,
      "jobTitle": jobTitle,
      "phone": phone,
      "region": region,
      "imageUrl" : imageUrl,
    };
  }
}
