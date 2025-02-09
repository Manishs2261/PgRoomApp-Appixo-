import 'package:flutter/cupertino.dart';
import 'package:pgroom/flavor_config.dart';

import 'common_main.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvironment.setUpEnv(Environment.dev);
  commonMain();
}