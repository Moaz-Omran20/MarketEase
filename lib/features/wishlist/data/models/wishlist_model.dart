class WishlistModel {
  WishlistModel({
      num? sold, 
      List<String>? images, 
      List<Subcategory>? subcategory, 
      num? ratingsQuantity, 
      String? title,
      String? slug, 
      String? description, 
      num? quantity, 
      num? price, 
      String? imageCover, 
      Category? category, 
      Brand? brand, 
      num? ratingsAverage, 
      String? createdAt, 
      String? updatedAt, 
      num? v,String? id}){
    _sold = sold;
    _images = images;
    _subcategory = subcategory;
    _ratingsQuantity = ratingsQuantity;
    _id = id;
    _title = title;
    _slug = slug;
    _description = description;
    _quantity = quantity;
    _price = price;
    _imageCover = imageCover;
    _category = category;
    _brand = brand;
    _ratingsAverage = ratingsAverage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    id = id;
}

  WishlistModel.fromJson(dynamic json) {
    _sold = json['sold'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['subcategory'] != null) {
      _subcategory = [];
      json['subcategory'].forEach((v) {
        _subcategory?.add(Subcategory.fromJson(v));
      });
    }
    _ratingsQuantity = json['ratingsQuantity'];
    _id = json['_id'];
    _title = json['title'];
    _slug = json['slug'];
    _description = json['description'];
    _quantity = json['quantity'];
    _price = json['price'];
    _imageCover = json['imageCover'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    _ratingsAverage = json['ratingsAverage'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    id = json['id'];
  }
  num? _sold;
  List<String>? _images;
  List<Subcategory>? _subcategory;
  num? _ratingsQuantity;
  String? _id;
  String? _title;
  String? _slug;
  String? _description;
  num? _quantity;
  num? _price;
  String? _imageCover;
  Category? _category;
  Brand? _brand;
  num? _ratingsAverage;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? id;
WishlistModel copyWith({  num? sold,
  List<String>? images,
  List<Subcategory>? subcategory,
  num? ratingsQuantity,
  String? id,
  String? title,
  String? slug,
  String? description,
  num? quantity,
  num? price,
  String? imageCover,
  Category? category,
  Brand? brand,
  num? ratingsAverage,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => WishlistModel(  sold: sold ?? _sold,
  images: images ?? _images,
  subcategory: subcategory ?? _subcategory,
  ratingsQuantity: ratingsQuantity ?? _ratingsQuantity,
  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  description: description ?? _description,
  quantity: quantity ?? _quantity,
  price: price ?? _price,
  imageCover: imageCover ?? _imageCover,
  category: category ?? _category,
  brand: brand ?? _brand,
  ratingsAverage: ratingsAverage ?? _ratingsAverage,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  num? get sold => _sold;
  List<String>? get images => _images;
  List<Subcategory>? get subcategory => _subcategory;
  num? get ratingsQuantity => _ratingsQuantity;
  String? get title => _title;
  String? get slug => _slug;
  String? get description => _description;
  num? get quantity => _quantity;
  num? get price => _price;
  String? get imageCover => _imageCover;
  Category? get category => _category;
  Brand? get brand => _brand;
  num? get ratingsAverage => _ratingsAverage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sold'] = _sold;
    map['images'] = _images;
    if (_subcategory != null) {
      map['subcategory'] = _subcategory?.map((v) => v.toJson()).toList();
    }
    map['ratingsQuantity'] = _ratingsQuantity;
    map['_id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['description'] = _description;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['imageCover'] = _imageCover;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_brand != null) {
      map['brand'] = _brand?.toJson();
    }
    map['ratingsAverage'] = _ratingsAverage;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['id'] = _id;
    return map;
  }

}

/// _id : "64089bbe24b25627a253158b"
/// name : "DeFacto"
/// slug : "defacto"
/// image : "https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"

class Brand {
  Brand({
      String? id, 
      String? name, 
      String? slug, 
      String? image,}){
    _id = id;
    _name = name;
    _slug = slug;
    _image = image;
}

  Brand.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _slug = json['slug'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _slug;
  String? _image;
Brand copyWith({  String? id,
  String? name,
  String? slug,
  String? image,
}) => Brand(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  image: image ?? _image,
);
  String? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image'] = _image;
    return map;
  }

}

/// _id : "6439d58a0049ad0b52b9003f"
/// name : "Women's Fashion"
/// slug : "women's-fashion"
/// image : "https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"

class Category {
  Category({
      String? id, 
      String? name, 
      String? slug, 
      String? image,}){
    _id = id;
    _name = name;
    _slug = slug;
    _image = image;
}

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _slug = json['slug'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _slug;
  String? _image;
Category copyWith({  String? id,
  String? name,
  String? slug,
  String? image,
}) => Category(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  image: image ?? _image,
);
  String? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image'] = _image;
    return map;
  }

}

/// _id : "6407f1bcb575d3b90bf95797"
/// name : "Women's Clothing"
/// slug : "women's-clothing"
/// category : "6439d58a0049ad0b52b9003f"

class Subcategory {
  Subcategory({
      String? id, 
      String? name, 
      String? slug, 
      String? category,}){
    _id = id;
    _name = name;
    _slug = slug;
    _category = category;
}

  Subcategory.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _slug = json['slug'];
    _category = json['category'];
  }
  String? _id;
  String? _name;
  String? _slug;
  String? _category;
Subcategory copyWith({  String? id,
  String? name,
  String? slug,
  String? category,
}) => Subcategory(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  category: category ?? _category,
);
  String? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['category'] = _category;
    return map;
  }

}