import 'package:resume_builder/services/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

class SigninScreenViewModel extends BaseViewModel {
  String title = "MyNews";
  bool isLoading = false;

  String _emailId = '';
  String _password = '';

  String get emailId => _emailId;
  String get password => _password;

  set emailId(String value) {
    _emailId = value;
  }

  set password(String value) {
    _password = value;
  }

  void updateIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<String> signInUser() async {
    if (emailId == '' || password == '') {
      return 'EMPTY';
    } else {
      String result = await FirebaseAuthService()
          .signIn(email: emailId, password: password);
      return result;
    }
  }
}
