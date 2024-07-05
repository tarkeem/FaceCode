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
  String? coverUrl;
  String? bio;
  String? fullNameLowerCase;
  List<String>? followers;
  List<String>? following;
  List<String>? favPosts;

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
      this.imageUrl,
      this.bio,
      this.coverUrl,
      this.followers,
      this.following,
      this.favPosts}) {
    fullNameLowerCase =
        '${firstName?.toLowerCase()} ${lastName?.toLowerCase()}';
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        phone = json['phone'],
        city = json['city'],
        country = json['country'],
        state = json['state'],
        jobTitle = json['jobTitle'],
        imageUrl = json['imageUrl'],
        bio = json['bio'],
        coverUrl = json['coverUrl'],
        followers = List<String>.from(json['followers'] ?? []),
        following = List<String>.from(json['following'] ?? []),
        favPosts = List<String>.from(json['favPosts'] ?? []) {
    fullNameLowerCase = json['fullNameLowerCase'] ??
        '${firstName?.toLowerCase()} ${lastName?.toLowerCase()}';
  }
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
      "bio": bio,
      "coverUrl": coverUrl,
      "fullNameLowerCase": fullNameLowerCase,
      "followers": followers,
      "following": following,
      "favPosts": favPosts,
    };
  }
}
