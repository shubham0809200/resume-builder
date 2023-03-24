import 'package:resume_builder/models/user.model.dart';
import 'package:resume_builder/services/firebase_auth_service.dart';
import 'package:resume_builder/services/firebase_user_service.dart';
import 'package:stacked/stacked.dart';

class SignupScreenViewModel extends BaseViewModel {
  String title = "MyNews";

  bool isLoading = false;

  UserDataModel user = UserDataModel(
    name: '',
    email: '',
  );

  String password = '';

  void updateIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<String> signInUser() async {
    if (user.name == '' || user.email == '' || password == '') {
      return 'EMPTY';
    } else {
      String result = await FirebaseAuthService()
          .signUp(email: user.email, password: password);

      if (result == 'SUCCESS') {
        await addUserData(UserDataModel(
          id: FirebaseAuthService().user.uid,
          name: user.name,
          email: user.email,
        ));
      }
      return result;
    }
  }

  Future addUserData(UserDataModel user) async {
    await FirebaseUserService().addUser(user.toJson());
  }
}
