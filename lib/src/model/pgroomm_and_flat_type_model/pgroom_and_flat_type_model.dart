class PgRoomAndFlatTypeModel {
  String? triplePersionPrice;
  String? faimlyPrice;
  String? fourPersionPrice;
  String? singlePersonPrice;
  String? doublePersionPrice;
  String? bhkType;
  String? roomType;

  PgRoomAndFlatTypeModel(
      {this.triplePersionPrice,
        this.faimlyPrice,
        this.fourPersionPrice,
        this.singlePersonPrice,
        this.doublePersionPrice,
        this.bhkType,
        this.roomType});

  PgRoomAndFlatTypeModel.fromJson(Map<String, dynamic> json) {
    triplePersionPrice = json['triplePersionPrice'];
    faimlyPrice = json['faimlyPrice'];
    fourPersionPrice = json['fourPersionPrice'];
    singlePersonPrice = json['singlePersonPrice'];
    doublePersionPrice = json['doublePersionPrice'];
    bhkType = json['bhkType'];
    roomType = json['roomType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['triplePersionPrice'] = this.triplePersionPrice;
    data['faimlyPrice'] = this.faimlyPrice;
    data['fourPersionPrice'] = this.fourPersionPrice;
    data['singlePersonPrice'] = this.singlePersonPrice;
    data['doublePersionPrice'] = this.doublePersionPrice;
    data['bhkType'] = this.bhkType;
    data['roomType'] = this.roomType;
    return data;
  }
}
