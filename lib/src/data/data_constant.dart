class CollectionName{

  static const String baseName = "Collection";
  static const String food = "${baseName}Food";
  static const String services = "${baseName}Services";
  static const String sellAndBuy = "${baseName}SellAndBuy";
  static const String room = "${baseName}Room";
  static const String user = "${baseName}User";
  static const String review = "${baseName}Review";


}

//
// flutter build apk --flavor dev --release -t lib/main_dev.dart
// flutter build apk --flavor uat --release -t lib/main_uat.dart
// flutter build apk --flavor prod --release -t lib/main_prod.dart

// flutter build appbundle --flavor prod --release -t lib/main_prod.dart
//shorebird release android --flavor prod --target lib/main_prod.dart
// shorebird patch --platforms=android --flavor=prod --target=lib/main_prod.dart --release-version=2.0.2+21
