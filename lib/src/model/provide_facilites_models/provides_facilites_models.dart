class ProvideFacilitesModel {
  bool? parking;
  bool? bed;
  bool? bedSheet;
  bool? wifi;
  bool? fan;
  bool? light;
  bool? chair;
  bool? washingMachin;
  bool? gadda;
  bool? table;
  bool? locker;

  ProvideFacilitesModel(
      {this.parking,
        this.bed,
        this.bedSheet,
        this.wifi,
        this.fan,
        this.light,
        this.chair,
        this.washingMachin,
        this.gadda,
        this.table,
        this.locker});

  ProvideFacilitesModel.fromJson(Map<String, dynamic> json) {
    parking = json['parking'];
    bed = json['bed'];
    bedSheet = json['bedSheet'];
    wifi = json['wifi'];
    fan = json['fan'];
    light = json['light'];
    chair = json['chair'];
    washingMachin = json['washingMachin'];
    gadda = json['gadda'];
    table = json['table'];
    locker = json['locker'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parking'] = this.parking;
    data['bed'] = this.bed;
    data['bedSheet'] = this.bedSheet;
    data['wifi'] = this.wifi;
    data['fan'] = this.fan;
    data['light'] = this.light;
    data['chair'] = this.chair;
    data['washingMachin'] = this.washingMachin;
    data['gadda'] = this.gadda;
    data['table'] = this.table;
    data['locker'] = this.locker;
    return data;
  }
}
