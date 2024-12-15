class ServicesModel {
  String? atCreate;
  List<String>? image;
  String? address;
  String? city;
  bool? isDelete;
  String? latitude;
  String? description;
  List<ServiceFAQ>? serviceFAQ;
  String? uId;
  String? atUpdate;
  bool? disable;
  String? servicesName;
  List<String>? report;
  String? state;
  String? landmark;
  String? sId;
  String? longitude;

  ServicesModel(
      {this.atCreate,
        this.image,
        this.address,
        this.city,
        this.isDelete,
        this.latitude,
        this.description,
        this.serviceFAQ,
        this.uId,
        this.atUpdate,
        this.disable,
        this.servicesName,
        this.report,
        this.state,
        this.landmark,
        this.sId,
        this.longitude});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    atCreate = json['atCreate'];
    image = json['image'].cast<String>();
    address = json['address'];
    city = json['city'];
    isDelete = json['isDelete'];
    latitude = json['latitude'];
    description = json['description'];
    if (json['serviceFAQ'] != null) {
      serviceFAQ = <ServiceFAQ>[];
      json['serviceFAQ'].forEach((v) {
        serviceFAQ!.add(new ServiceFAQ.fromJson(v));
      });
    }
    uId = json['u_id'];
    atUpdate = json['atUpdate'];
    disable = json['disable'];
    servicesName = json['servicesName'];
    report = json['report'].cast<String>();
    state = json['state'];
    landmark = json['landmark'];
    sId = json['s_id'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['atCreate'] = this.atCreate;
    data['image'] = this.image;
    data['address'] = this.address;
    data['city'] = this.city;
    data['isDelete'] = this.isDelete;
    data['latitude'] = this.latitude;
    data['description'] = this.description;
    if (this.serviceFAQ != null) {
      data['serviceFAQ'] = this.serviceFAQ!.map((v) => v.toJson()).toList();
    }
    data['u_id'] = this.uId;
    data['atUpdate'] = this.atUpdate;
    data['disable'] = this.disable;
    data['servicesName'] = this.servicesName;
    data['report'] = this.report;
    data['state'] = this.state;
    data['landmark'] = this.landmark;
    data['s_id'] = this.sId;
    data['longitude'] = this.longitude;
    return data;
  }
}

class ServiceFAQ {
  String? question;
  String? answer;

  ServiceFAQ({this.question, this.answer});

  ServiceFAQ.fromJson(Map<String, dynamic> json) {
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
