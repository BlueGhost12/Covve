import 'package:covve/Services/database.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

class ContactDetailsModel extends Model {
  DatabaseHelper dbService = locator<DatabaseHelper>();
}
