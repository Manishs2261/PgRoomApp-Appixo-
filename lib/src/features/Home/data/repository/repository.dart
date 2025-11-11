import '../../../../../services/api/api.dart';

class HomeRepository{

 static Future<void> getUser() async {
   print('ima call');
    final response = await ApiService().get("/users");
    print( 'ima call $response');
    if (response != null && response.statusCode == 200) {
      print(response.data);
    }
  }



}