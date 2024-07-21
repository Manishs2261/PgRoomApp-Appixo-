class OldGoodsModel {
  String? image;
  String? address;
  String? price;
  String? name;
  String? contactNumber;
  String? postDate;
  String? coverImageId;

  OldGoodsModel(
      {this.image,
        this.address,
        this.price,
        this.name,
        this.contactNumber,
        this.postDate,
        this.coverImageId
      });

  OldGoodsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    address = json['address'];
    price = json['price'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    postDate = json['postDate'];
    coverImageId = json['coverImageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['address'] = address;
    data['price'] = price;
    data['name'] = name;
    data['contactNumber'] = contactNumber;
    data['postDate'] = postDate;
    data['coverImageId'] = coverImageId;
    return data;
  }
}
