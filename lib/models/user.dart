class User {
  int? id;
  String? name;
  String? type;
  String? imageUrl;


  User({this.id, this.name, this.type, this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['image_url'] = imageUrl;
    return data;
  }
}
