class SellAndBuyFomModel {
  List<String>? image;
  String? address;
  String? city;
  bool? isDelete;
  String? atCreated;
  String? description;
  String? rUid;
  String? sabId;
  String? itemName;
  bool? disable;
  String? price;
  bool? report;
  String? state;
  String? landmark;
  String? atUpdated;

  SellAndBuyFomModel(
      {this.image,
        this.address,
        this.city,
        this.isDelete,
        this.atCreated,
        this.description,
        this.rUid,
        this.sabId,
        this.itemName,
        this.disable,
        this.price,
        this.report,
        this.state,
        this.landmark,
        this.atUpdated});

  SellAndBuyFomModel.fromJson(Map<String, dynamic> json) {
    image = json['image'].cast<String>();
    address = json['address'];
    city = json['city'];
    isDelete = json['isDelete'];
    atCreated = json['atCreated'];
    description = json['description'];
    rUid = json['rUid'];
    sabId = json['sabId'];
    itemName = json['itemName'];
    disable = json['disable'];
    price = json['price'];
    report = json['report'];
    state = json['state'];
    landmark = json['landmark'];
    atUpdated = json['atUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['address'] = this.address;
    data['city'] = this.city;
    data['isDelete'] = this.isDelete;
    data['atCreated'] = this.atCreated;
    data['description'] = this.description;
    data['rUid'] = this.rUid;
    data['sabId'] = this.sabId;
    data['itemName'] = this.itemName;
    data['disable'] = this.disable;
    data['price'] = this.price;
    data['report'] = this.report;
    data['state'] = this.state;
    data['landmark'] = this.landmark;
    data['atUpdated'] = this.atUpdated;
    return data;
  }
}
