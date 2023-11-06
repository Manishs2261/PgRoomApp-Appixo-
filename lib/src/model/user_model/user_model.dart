class UserPersonModel {
  String? city;
  String? email;
  String? name;

  UserPersonModel({this.city, this.email, this.name});

  UserPersonModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    email = json['email'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['email'] = this.email;
    data['Name'] = this.name;
    return data;
  }
}
