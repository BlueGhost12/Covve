import 'package:covve/Models/contact.dart';
import 'package:covve/Scoped_models/contact_add_edit_model.dart';
import 'package:covve/Scoped_models/contact_details_model.dart';
import 'package:covve/Scoped_models/contact_edit_model.dart';
import 'package:covve/Scoped_models/contact_list_model.dart';
import 'package:covve/Scoped_models/signup_model.dart';
import 'package:covve/Services/database.dart';
import 'package:covve/Services/sharedPrefs.dart';
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
  locator.registerFactoryParam<ContactDetailsModel, Contact, void>(
      (contact, params2) => ContactDetailsModel(contact: contact));
  locator.registerFactoryParam<ContactEditModel, Contact, void>(
      (contact, params2) => ContactEditModel(contact: contact));
}
