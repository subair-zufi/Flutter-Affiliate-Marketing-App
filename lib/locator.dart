import 'package:asuser/apis/firestore_api.dart';
import 'package:get_it/get_it.dart';

GetIt productLocator= GetIt();
setupProductLocator(){
  productLocator.registerLazySingleton(() => Api('Products'));
  
}