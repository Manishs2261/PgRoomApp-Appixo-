import 'package:get_it/get_it.dart';

import 'api/api.dart';

final sl = GetIt.instance;

void setupServiceLocator(){
  sl.registerLazySingleton<ApiService>(() => ApiService());

}