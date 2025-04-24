import 'package:flutter/cupertino.dart';


 import 'common_main.dart';
import 'flavor_config.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvironment.setUpEnv(Environment.prod);
  commonMain();
}