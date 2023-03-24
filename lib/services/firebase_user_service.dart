import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_builder/services/firebase_auth_service.dart';
import 'package:resume_builder/ui/widgets/toaster.dart';

class FirebaseUserService {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

  Future addUser(Map<String, dynamic>? user) async {
    try {
      await _userCollection
          .doc(FirebaseAuthService().user.uid)
          .set(user, SetOptions(merge: true));
      return 'SUCCESS';
    } on FirebaseException catch (e) {
      buildToaster(message: e.message.toString());
      return e.message.toString();
    }
  }
}
