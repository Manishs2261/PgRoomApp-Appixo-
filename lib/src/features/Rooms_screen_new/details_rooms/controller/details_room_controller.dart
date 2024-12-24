import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/room_model.dart';

class DetailsRoomController extends GetxController {

  RxDouble ratingNow = 0.0.obs;


  final RoomModel data = Get.arguments;

  RxInt currentPage = 0.obs;


}