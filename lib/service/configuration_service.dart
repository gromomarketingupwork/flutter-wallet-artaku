import 'package:shared_preferences/shared_preferences.dart';

abstract class IConfigurationService {
  Future<void> setMnemonic(String value);
  Future<void> setupDone(bool value);
  Future<void> setPrivateKey(String value);
  Future<void> setUsername(String value);
  Future<void> setEmail(String value);
  Future<void> setPin(String value);
  String getMnemonic();
  String getPrivateKey();
  bool didSetupWallet();
  String getUsername();
  String getEmail();
  String getPin();
}

class ConfigurationService implements IConfigurationService {
  SharedPreferences _preferences;
  ConfigurationService(this._preferences);

  @override
  Future<void> setMnemonic(String value) async {
    await _preferences.setString("mnemonic", value ?? "");
  }

  @override
  Future<void> setPrivateKey(String value) async {
    await _preferences.setString("privateKey", value ?? "");
  }

  @override
  Future<void> setupDone(bool value) async {
    await _preferences.setBool("didSetupWallet", value);
  }

  // gets
  @override
  String getMnemonic() {
    return _preferences.getString("mnemonic");
  }

  @override
  String getPrivateKey() {
    return _preferences.getString("privateKey");
  }

  @override
  bool didSetupWallet() {
    return _preferences.getBool("didSetupWallet") ?? false;
  }

  @override
  String getEmail() {
    return _preferences.getString("email");

  }

  @override
  String getUsername() {
    return _preferences.getString("username");
  }

  @override
  Future<void> setEmail(String value) async {
    await _preferences.setString("email", value ?? "");

  }

  @override
  Future<void> setUsername(String value) async {
    await _preferences.setString("username", value ?? "");

  }

  @override
  String getPin() {
    return _preferences.getString("pin");

  }

  @override
  Future<void> setPin(String value) async {
    await _preferences.setString("pin", value ?? "");
  }
}
