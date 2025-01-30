import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../../../data/repository/apis/apis.dart';
import '../../../../../../utils/logger/logger.dart';
import '../../../../../Rooms_screen_new/model/room_model.dart';

class RoomUpdateListController extends GetxController {
  RxList<RoomModel> roomListData = <RoomModel>[].obs;
  DocumentSnapshot? lastDocument;
  RxBool isLoadingMore = false.obs;
  RxBool hasMoreData = true.obs;

  final RxBool isButtonVisible = true.obs;
  var isLoadingInitial = true.obs;

  @override
  void onInit() {
    // Initial data load
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    // If no data, show the initial loading indicator
    if (roomListData.isEmpty) {
      isLoadingInitial.value = true;
    } else {
      isLoadingMore.value = true; // For pagination
    }

    try {
      print(ApisClass.auth.currentUser!.uid);
      // Construct query for Firestore
      Query<Map<String, dynamic>> query = ApisClass.firebaseFirestore
          .collection('DevRoomCollection')
      .where('u_id', isEqualTo: ApisClass.auth.currentUser!.uid)
          .orderBy('atCreate') // Ensure consistent sorting
          .limit(10); // Limit the number of documents per fetch

      // Add pagination logic
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      // Fetch data from Firestore
      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        // Map documents to RoomModel and add to the list
        roomListData.addAll(
          snapshot.docs.map((e) => RoomModel.fromJson(e.data())).toList(),
        );
        // Update the last document for the next query
        lastDocument = snapshot.docs.last;
      } else {
        // No more data to load
        hasMoreData.value = false;
      }
    } catch (e) {
      // Log errors for debugging
      AppLoggerHelper.error("Error fetching data: $e");
    } finally {
      // Reset loading states
      isLoadingMore.value = false;
      isLoadingInitial.value = false;
    }
  }

  // Refresh data (pull-to-refresh)
  Future<void> refreshData() async {
    // Clear existing data and reset pagination
    roomListData.clear();
    lastDocument = null;
    hasMoreData.value = true;

    // Fetch the first batch of data
    await fetchData();
  }

  Future<void> loadMoreData() async {
    if (!isLoadingMore.value && hasMoreData.value) {
      await fetchData();
    }
  }
}
