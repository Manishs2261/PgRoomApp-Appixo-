class PermissionModel {
  bool? cooking;
  bool? girl;
  bool? faimlyMember;
  bool? boy;
  String? cookingType;

  PermissionModel(
      {this.cooking, this.girl, this.faimlyMember, this.boy, this.cookingType});

  PermissionModel.fromJson(Map<String, dynamic> json) {
    cooking = json['cooking'];
    girl = json['girl'];
    faimlyMember = json['faimlyMember'];
    boy = json['boy'];
    cookingType = json['cookingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cooking'] = this.cooking;
    data['girl'] = this.girl;
    data['faimlyMember'] = this.faimlyMember;
    data['boy'] = this.boy;
    data['cookingType'] = this.cookingType;
    return data;
  }
}
