import 'package:get/get.dart';
import 'package:pgroom/src/model/tiffin_services_model/tiffen_services_model.dart';

class EditTiffineScreenController extends GetxController{

  var itemId ;
   TiffineServicesModel data = TiffineServicesModel();

  EditTiffineScreenController(this.itemId, this.data);

}