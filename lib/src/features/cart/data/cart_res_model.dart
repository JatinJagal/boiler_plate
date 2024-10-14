class CartResponsModel {
  int? id;
  int? userid;
  int? productid;
  String? title;
  double? price;
  String? image;

  CartResponsModel(
      {this.id,
      this.userid,
      this.productid,
      this.title,
      this.price,
      this.image});

  CartResponsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    productid = json['productid'];
    title = json['title'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['productid'] = productid;
    data['title'] = title;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
