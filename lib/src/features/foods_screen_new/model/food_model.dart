class FoodModel {
  String? breakfastAndLunchOrDinnerCost;
  List<String>? messRules;
  String? city;
  String? roti;
  String? latitude;
  String? description;
  String? shopName;
  String? typeOfShop;
  String? lunchAndDinnerCost;
  String? dal;
  String? sabji;
  String? uId;
  String? atUpdate;
  String? state;
  String? landmark;
  String? longitude;
  String? atCreate;
  List<String>? image;
  String? address;
  List<RestructureMenuList>? restructureMenuList;
  bool? isDelete;
  String? breakfastCost;
  String? lunchOrDinnerCost;
  List<DailyItemList>? dailyItemList;
  bool? disable;
  List<FoodFAQ>? fAQ;
  List<String>? report;
  List<SubscriptionList>? subscriptionList;
  String? thaliCost;
  String? fId;
  String? aCupOfRice;

  FoodModel(
      {this.breakfastAndLunchOrDinnerCost,
      this.messRules,
      this.city,
      this.roti,
      this.latitude,
      this.description,
      this.shopName,
      this.typeOfShop,
      this.lunchAndDinnerCost,
      this.dal,
      this.sabji,
      this.uId,
      this.atUpdate,
      this.state,
      this.landmark,
      this.longitude,
      this.atCreate,
      this.image,
      this.address,
      this.restructureMenuList,
      this.isDelete,
      this.breakfastCost,
      this.lunchOrDinnerCost,
      this.dailyItemList,
      this.disable,
      this.fAQ,
      this.report,
      this.subscriptionList,
      this.thaliCost,
      this.fId,
      this.aCupOfRice});

  FoodModel.fromJson(Map<String, dynamic> json) {
    breakfastAndLunchOrDinnerCost = json['breakfastAndLunchOrDinnerCost'];
    messRules = json['messRules'].cast<String>();
    city = json['city'];
    roti = json['roti'];
    latitude = json['latitude'];
    description = json['description'];
    shopName = json['shopName'];
    typeOfShop = json['typeOfShop'];
    lunchAndDinnerCost = json['lunchAndDinnerCost'];
    dal = json['dal'];
    sabji = json['sabji'];
    uId = json['u_id'];
    atUpdate = json['atUpdate'];
    state = json['state'];
    landmark = json['landmark'];
    longitude = json['longitude'];
    atCreate = json['atCreate'];
    image = json['image'].cast<String>();
    address = json['address'];
    if (json['RestructureMenuList'] != null) {
      restructureMenuList = <RestructureMenuList>[];
      json['RestructureMenuList'].forEach((v) {
        restructureMenuList!.add(new RestructureMenuList.fromJson(v));
      });
    }
    isDelete = json['isDelete'];
    breakfastCost = json['breakfastCost'];
    lunchOrDinnerCost = json['lunchOrDinnerCost'];
    if (json['DailyItemList'] != null) {
      dailyItemList = <DailyItemList>[];
      json['DailyItemList'].forEach((v) {
        dailyItemList!.add(new DailyItemList.fromJson(v));
      });
    }
    disable = json['disable'];
    if (json['FAQ'] != null) {
      fAQ = <FoodFAQ>[];
      json['FAQ'].forEach((v) {
        fAQ!.add(new  FoodFAQ.fromJson(v));
      });
    }
    report = json['report'].cast<String>();
    if (json['SubscriptionList'] != null) {
      subscriptionList = <SubscriptionList>[];
      json['SubscriptionList'].forEach((v) {
        subscriptionList!.add(new SubscriptionList.fromJson(v));
      });
    }
    thaliCost = json['thaliCost'];
    fId = json['f_id'];
    aCupOfRice = json['aCupOfRice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breakfastAndLunchOrDinnerCost'] = this.breakfastAndLunchOrDinnerCost;
    data['messRules'] = this.messRules;
    data['city'] = this.city;
    data['roti'] = this.roti;
    data['latitude'] = this.latitude;
    data['description'] = this.description;
    data['shopName'] = this.shopName;
    data['typeOfShop'] = this.typeOfShop;
    data['lunchAndDinnerCost'] = this.lunchAndDinnerCost;
    data['dal'] = this.dal;
    data['sabji'] = this.sabji;
    data['u_id'] = this.uId;
    data['atUpdate'] = this.atUpdate;
    data['state'] = this.state;
    data['landmark'] = this.landmark;
    data['longitude'] = this.longitude;
    data['atCreate'] = this.atCreate;
    data['image'] = this.image;
    data['address'] = this.address;
    if (this.restructureMenuList != null) {
      data['RestructureMenuList'] =
          this.restructureMenuList!.map((v) => v.toJson()).toList();
    }
    data['isDelete'] = this.isDelete;
    data['breakfastCost'] = this.breakfastCost;
    data['lunchOrDinnerCost'] = this.lunchOrDinnerCost;
    if (this.dailyItemList != null) {
      data['DailyItemList'] =
          this.dailyItemList!.map((v) => v.toJson()).toList();
    }
    data['disable'] = this.disable;
    if (this.fAQ != null) {
      data['FAQ'] = this.fAQ!.map((v) => v.toJson()).toList();
    }
    data['report'] = this.report;
    if (this.subscriptionList != null) {
      data['SubscriptionList'] =
          this.subscriptionList!.map((v) => v.toJson()).toList();
    }
    data['thaliCost'] = this.thaliCost;
    data['f_id'] = this.fId;
    data['aCupOfRice'] = this.aCupOfRice;
    return data;
  }
}

class RestructureMenuList {
  String? price;
  String? name;

  RestructureMenuList({this.price, this.name});

  RestructureMenuList.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['name'] = this.name;
    return data;
  }
}

class DailyItemList {
  String? name;
  String? price;

  DailyItemList({this.name, this.price});

  DailyItemList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class FoodFAQ {
  String? question;
  String? answer;

  FoodFAQ({this.question, this.answer});

  FoodFAQ.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}

class SubscriptionList {
  String? name;
  String? price;

  SubscriptionList({this.name, this.price});

  SubscriptionList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
