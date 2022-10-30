import 'package:flutter/material.dart';
import 'package:deta/deta.dart';
import 'package:http_client_deta_api/http_client_deta_api.dart';
import 'package:http/http.dart' as http;
import 'package:template/auth/secrets.dart';

class LogginProvider extends ChangeNotifier {
  bool _userIsLogedIn = false;

  late var deta;
  late var detabase;
  final String dbName = "users";

  LogginProvider() {
    connectToDb();
  }

  bool get userIsLogedIn => _userIsLogedIn;

  void login({required String userName, required String password}) {}

  Future<bool> checkIfUsernameIsFree(String userName) async {
    var queryData =
        await detabase.fetch(query: [DetaQuery("userName").equalTo(userName)]);
    if (queryData["items"].isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void createUser(
      {required String userName,
      required String password,
      String email = ""}) async {
    var queryData = await detabase.put({
      "userName": userName,
      "password": password,
      "email": email,
      "color_profiles": [],
    });
  }

  void connectToDb() {
    deta = Deta(
        projectKey: detaProjectKey,
        client: HttpClientDetaApi(http: http.Client()));
    detabase = deta.base(dbName);
  }

  void userLogin() {
    _userIsLogedIn = !_userIsLogedIn;
    notifyListeners();
  }
}
