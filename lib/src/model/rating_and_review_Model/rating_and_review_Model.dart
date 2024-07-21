class RatingAndReviewModel {
  double? rating;
  String? title;
  String? currentDate;
  String? userId;
  String? userName;
  String? userImage;
  double? tiffineRating;
  String? tiffineTitle;
  String? tiffineUserId;

  RatingAndReviewModel(
      {this.rating,
      this.title,
      this.currentDate,
      this.userId,
      this.userName,
      this.userImage,
      this.tiffineRating,
      this.tiffineTitle,
      this.tiffineUserId});

  RatingAndReviewModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    title = json['title'];
    currentDate = json['currentDate'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    tiffineUserId = json['tiffineUserId'];
    tiffineTitle = json['tiffineTitle'];
    tiffineRating = json['tiffineRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['title'] = title;
    data['currentDate'] = currentDate;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userImage'] = userImage;
    data['tiffineRating'] = tiffineRating;
    data['tiffineTitle'] = tiffineTitle;
    data['tiffineUserId'] = tiffineUserId;
    return data;
  }
}
