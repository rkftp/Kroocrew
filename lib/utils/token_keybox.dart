import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyBox {
  static final KeyBox _keyBox = KeyBox._internal();

  factory KeyBox() => _keyBox;


  final storage = FlutterSecureStorage();

  String _key = 'token';

  KeyBox._internal(){
    getToken();
    deleteToken();
  }

  Future<void> setToken(String token) async {
    await storage.write(key: _key, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _key);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: _key);
  }

  KeyBox to() => _keyBox;

}