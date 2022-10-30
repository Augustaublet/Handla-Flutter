import 'package:template/data/login_provider.dart';

void main() {
  var test = LogginProvider();
  //test.createUser(userName: "test", password: "test");
  test.checkIfUsernameIsFree("test");
}
