// / sold : 239
// / images : ["https://ecommerce.routemisr.com/Route-Academy-products/1678296691201-1.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1678296691201-2.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1678296691202-4.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1678296691203-5.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1678296691201-3.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1678296691203-6.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1678296691204-7.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1678296691204-8.jpeg"]
// / subcategory : [{"_id":"6407f39bb575d3b90bf957df","name":"TVs, Satellites & Accessories","slug":"tvs-satellites-and-accessories","category":"6439d2d167d9aa4ca970649f"}]
// / ratingsQuantity : 98
// / _id : "6408c674ab73fcc15c761392"
// / title : "24-Inch Full HD Curved Monitor Black"
// / slug : "24-inch-full-hd-curved-monitor-black"
// / description : "Offers a vivid display that contains everything you need\nStands for evolving office requirements\nWide viewing angles keep colors consistent no matter where you sit\nOptimizes eye comfort\nReduces harmful blue light emissions\nThis monitor's Eye Saver mode makes viewing more comfortable and less taxing on the eyes"
// / quantity : 303
// / price : 4499
// / priceAfterDiscount : 3399
// / availableColors : []
// / imageCover : "https://ecommerce.routemisr.com/Route-Academy-products/1678296691139-cover.jpeg"
// / category : {"_id":"6439d2d167d9aa4ca970649f","name":"Electronics","slug":"electronics","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511121316.png"}
// / brand : {"_id":"64089df124b25627a25315ab","name":"Samsung","slug":"samsung","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678286321029.png"}
// / ratingsAverage : 4.7
// / createdAt : "2023-03-08T17:31:32.337Z"
// / updatedAt : "2026-03-06T14:37:22.932Z"
// / id : "6408c674ab73fcc15c761392"

class ProductModel {
  ProductModel({
      num? sold, 
      List<String>? images, 
      List<Subcategory>? subcategory, 
      num? ratingsQuantity, 
      String? id, 
      String? title, 
      String? slug, 
      String? description, 
      num? quantity, 
      num? price, 
      num? priceAfterDiscount, 
      List<dynamic>? availableColors, 
      String? imageCover, 
      Category? category, 
      Brand? brand, 
      num? ratingsAverage, 
      String? createdAt, 
      String? updatedAt,}){
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
    _priceAfterDiscount = priceAfterDiscount;
    _availableColors = availableColors;
    _imageCover = imageCover;
    _category = category;
    _brand = brand;
    _ratingsAverage = ratingsAverage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _id = id;
}

  ProductModel.fromJson(dynamic json) {
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
    _priceAfterDiscount = json['priceAfterDiscount'];
    if (json['availableColors'] != null) {
      _availableColors = [];
      json['availableColors'].forEach((v) {
      });
    }
    _imageCover = json['imageCover'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    _ratingsAverage = json['ratingsAverage'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _id = json['id'];
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
  num? _priceAfterDiscount;
  List<dynamic>? _availableColors;
  String? _imageCover;
  Category? _category;
  Brand? _brand;
  num? _ratingsAverage;
  String? _createdAt;
  String? _updatedAt;
ProductModel copyWith({  num? sold,
  List<String>? images,
  List<Subcategory>? subcategory,
  num? ratingsQuantity,
  String? id,
  String? title,
  String? slug,
  String? description,
  num? quantity,
  num? price,
  num? priceAfterDiscount,
  List<dynamic>? availableColors,
  String? imageCover,
  Category? category,
  Brand? brand,
  num? ratingsAverage,
  String? createdAt,
  String? updatedAt,
}) => ProductModel(  sold: sold ?? _sold,
  images: images ?? _images,
  subcategory: subcategory ?? _subcategory,
  ratingsQuantity: ratingsQuantity ?? _ratingsQuantity,
  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  description: description ?? _description,
  quantity: quantity ?? _quantity,
  price: price ?? _price,
  priceAfterDiscount: priceAfterDiscount ?? _priceAfterDiscount,
  availableColors: availableColors ?? _availableColors,
  imageCover: imageCover ?? _imageCover,
  category: category ?? _category,
  brand: brand ?? _brand,
  ratingsAverage: ratingsAverage ?? _ratingsAverage,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get sold => _sold;
  List<String>? get images => _images;
  List<String> get fullImages {
    return _images?.map((img) {
      if (img.startsWith('http')) {
        return img;
      } else {
        return "https://ecommerce.routemisr.com/Route-Academy-products/$img";
      }
    }).toList() ?? [];
  }
  List<Subcategory>? get subcategory => _subcategory;
  num? get ratingsQuantity => _ratingsQuantity;
  String? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  String? get description => _description;
  num? get quantity => _quantity;
  num? get price => _price;
  num? get priceAfterDiscount => _priceAfterDiscount;
  List<dynamic>? get availableColors => _availableColors;
  String? get imageCover => _imageCover;
  Category? get category => _category;
  Brand? get brand => _brand;
  num? get ratingsAverage => _ratingsAverage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

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
    map['priceAfterDiscount'] = _priceAfterDiscount;
    if (_availableColors != null) {
      map['availableColors'] = _availableColors?.map((v) => v.toJson()).toList();
    }
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
    map['id'] = _id;
    return map;
  }

}

/// _id : "64089df124b25627a25315ab"
/// name : "Samsung"
/// slug : "samsung"
/// image : "https://ecommerce.routemisr.com/Route-Academy-brands/1678286321029.png"

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

/// _id : "6439d2d167d9aa4ca970649f"
/// name : "Electronics"
/// slug : "electronics"
/// image : "https://ecommerce.routemisr.com/Route-Academy-categories/1681511121316.png"

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

/// _id : "6407f39bb575d3b90bf957df"
/// name : "TVs, Satellites & Accessories"
/// slug : "tvs-satellites-and-accessories"
/// category : "6439d2d167d9aa4ca970649f"

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