class UserDataModel {
  late String? id;
  late String name;
  late String email;

  UserDataModel({
    this.id,
    required this.name,
    required this.email,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;

    return data;
  }
}
