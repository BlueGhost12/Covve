import 'package:covve/Scoped_models/contact_add_edit_model.dart';
import 'package:covve/Scoped_models/contact_details_model.dart';
import 'package:covve/Scoped_models/contact_list_model.dart';
import 'package:covve/Scoped_models/signup_model.dart';
import 'package:covve/Services/database.dart';
import 'package:covve/Services/sharedPrefs.dart';
import 'package:covve/Views/contact_details_view.dart';
import 'package:get_it/get_it.dart';
import 'Scoped_models/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //  register services
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);
  locator.registerFactory<SharedPrefs>(() => SharedPrefs());

  //  register models
  locator.registerFactory<LoginModel>(() => LoginModel());
  locator.registerFactory<SignUpModel>(() => SignUpModel());
  locator.registerFactory<ContactListModel>(() => ContactListModel());
  locator.registerFactory<ContactAddEditModel>(() => ContactAddEditModel());
  locator.registerFactory<ContactDetailsModel>(() => ContactDetailsModel());
}
