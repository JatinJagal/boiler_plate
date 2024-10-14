// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartDataModel {
  final int productId;
  final int userid;
  final String title;
  final double price;
  final String image;

  CartDataModel(
      {required this.productId,
      required this.userid,
      required this.title,
      required this.price,
      required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productid': productId,
      'userid': userid,
      'title': title,
      'price': price,
      'image': image,
    };
  }

  factory CartDataModel.fromMap(Map<String, dynamic> map) {
    return CartDataModel(
      productId: map['id'] as int,
      userid: map['userid'] as int,
      title: map['title'] as String,
      price: map['price'] as double,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartDataModel.fromJson(String source) =>
      CartDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
