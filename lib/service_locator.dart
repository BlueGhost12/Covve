import 'package:covve/Scoped_models/signup_model.dart';
import 'package:covve/Services/database.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'Scoped_models/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //  register services
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  //  register models
  locator.registerFactory<LoginModel>(() => LoginModel());
  locator.registerFactory<SignUpModel>(() => SignUpModel());
}
