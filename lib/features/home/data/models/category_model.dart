 // _id : "6439d61c0049ad0b52b90051"
 // name : "Music"
 // slug : "music"
 // image : "https://ecommerce.routemisr.com/Route-Academy-categories/1681511964020.jpeg"
 // createdAt : "2023-04-14T22:39:24.365Z"
 // updatedAt : "2023-04-14T22:39:24.365Z"

class CategoryModel {
  CategoryModel({
      String? id, 
      String? name, 
      String? slug, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _slug = slug;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CategoryModel.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _slug = json['slug'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _slug;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
CategoryModel copyWith({  String? id,
  String? name,
  String? slug,
  String? image,
  String? createdAt,
  String? updatedAt,
}) => CategoryModel(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}