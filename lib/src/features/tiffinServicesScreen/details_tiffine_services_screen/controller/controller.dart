import 'package:get/get.dart';
import 'package:pgroom/src/model/tiffin_services_model/tiffen_services_model.dart';

class DetailsTiffineController extends GetxController{

  var itemId ;
  TiffineServicesModel data = TiffineServicesModel();

  DetailsTiffineController(this.itemId, this.data);
}