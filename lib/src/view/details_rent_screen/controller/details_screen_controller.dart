import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';

class DetailsScreenController extends GetxController{

  RxBool isView = false.obs;
  final reviewController = TextEditingController().obs;

}

