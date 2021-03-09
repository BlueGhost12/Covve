import 'package:covve/Services/database.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class LoginModel extends Model {
  String email;
  String password;

  DatabaseHelper dbService = locator<DatabaseHelper>();

  Future<int> checkIfValidCredentials(String email, String password) async {
    return await dbService.checkIfValidCredentials(email, password);
  }
}
