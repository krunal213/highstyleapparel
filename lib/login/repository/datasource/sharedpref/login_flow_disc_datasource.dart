import 'package:highstyleapparel/login/contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFlowDiscDataSourceImpl implements LoginFlowDiscDataSource {
  late final Future<SharedPreferences> _prefs;

  LoginFlowDiscDataSourceImpl(this._prefs);

}
