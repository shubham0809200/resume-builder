import 'package:resume_builder/models/resume.model.dart';
import 'package:resume_builder/services/firebase_auth_service.dart';
import 'package:resume_builder/services/firebase_resume_service.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class HomeScreenViewModel extends FutureViewModel {
  FirebaseResumeService firebaseResumeService = FirebaseResumeService();

  List<ResumeForm> resumes = [];

  bool isAscending = true;

  Future<List<ResumeForm>> getResumes() async {
    return await firebaseResumeService.getResumes(isAscending);
  }

  Future signOutUser() async {
    await FirebaseAuthService().signOut();
  }

  // formate date to string dd/mm/yyyy
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Delete Resume
  Future deleteResume(String id) async {
    return FirebaseResumeService().deleteResume(id);
  }

  @override
  Future futureToRun() => getResumes();
}
