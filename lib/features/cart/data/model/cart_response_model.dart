class CartResponseModel {
  final List<CartProductModel> products;
  final int totalPrice;

  CartResponseModel({
    required this.products,
    required this.totalPrice,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    List<CartProductModel> products = [];

    for (var item in json["data"]["products"]) {
      products.add(CartProductModel.fromJson(item));
    }

    return CartResponseModel(
      products: products,
      totalPrice: json["data"]["totalCartPrice"],
    );
  }
}

class CartProductModel {
  final String id;
  final int count;
  final int price;
  final String title;
  final String image;

  CartProductModel({
    required this.id,
    required this.count,
    required this.price,
    required this.title,
    required this.image,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json["product"]["id"],
      count: json["count"],
      price: json["price"],
      title: json["product"]["title"],
      image: json["product"]["imageCover"],
    );
  }
}