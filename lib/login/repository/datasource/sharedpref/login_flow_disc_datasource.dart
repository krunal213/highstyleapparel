import 'package:highstyleapparel/login/contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFlowDiscDataSourceImpl implements LoginFlowDiscDataSource {
  late final SharedPreferences _prefs;

  LoginFlowDiscDataSourceImpl(this._prefs);

  @override
  Future<bool> saveCustomerId(String userId) async {
    final SharedPreferences prefs = _prefs;

    return await prefs.setString("customerId", userId);
  }

  @override
  Future<String?> getCustomerId() async {
    final SharedPreferences prefs = _prefs;

    return prefs.getString("customerId");
  }
}
