class AdditionChargesAndDoorClosingModel {
  bool? electricityBill;
  bool? fexibleTime;
  String? restrictedTime;
  bool? waterBill;

  AdditionChargesAndDoorClosingModel(
      {this.electricityBill,
        this.fexibleTime,
        this.restrictedTime,
        this.waterBill});

  AdditionChargesAndDoorClosingModel.fromJson(Map<String, dynamic> json) {
    electricityBill = json['electricityBill'];
    fexibleTime = json['fexibleTime'];
    restrictedTime = json['restrictedTime'];
    waterBill = json['waterBill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['electricityBill'] = this.electricityBill;
    data['fexibleTime'] = this.fexibleTime;
    data['restrictedTime'] = this.restrictedTime;
    data['waterBill'] = this.waterBill;
    return data;
  }
}
