import 'package:get/get.dart';

import '../../../data/repository/apis/user_apis.dart';
import '../../auth_screen/Model/user_model.dart';

class HomeController extends GetxController {
  RxList<UserModel> user = <UserModel>[].obs;
  RxBool isLoading = true.obs;

  // For initial loading state
  // Stores the list of rooms

  @override
  void onInit() {
    // TODO: implement onInit

    fetchUserData();
    super.onInit();
  }

  void fetchUserData() async {
    try {
      isLoading(true); // Set loading to true
      List<UserModel> fetchedUsers = await UserApis.getUserDataList();
      user.assignAll(fetchedUsers);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data");
    } finally {
      isLoading(false); // Set loading to false
    }
  }
}
