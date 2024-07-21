class RatingSummaryModel {
  int? ratingStar02;
  int? ratingStar01;
  int? ratingStar04;
  int? ratingStar03;
  int? ratingStar05;

  RatingSummaryModel(
      {this.ratingStar02,
        this.ratingStar01,
        this.ratingStar04,
        this.ratingStar03,
        this.ratingStar05});

  RatingSummaryModel.fromJson(Map<String, dynamic> json) {
    ratingStar02 = json['ratingStar02'];
    ratingStar01 = json['ratingStar01'];
    ratingStar04 = json['ratingStar04'];
    ratingStar03 = json['ratingStar03'];
    ratingStar05 = json['ratingStar05'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ratingStar02'] = ratingStar02;
    data['ratingStar01'] = ratingStar01;
    data['ratingStar04'] = ratingStar04;
    data['ratingStar03'] = ratingStar03;
    data['ratingStar05'] = ratingStar05;
    return data;
  }
}
