import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_builder/models/resume.model.dart';

class FirebaseResumeService {
  final CollectionReference _resumeCollection =
      FirebaseFirestore.instance.collection('resumes');

  // Get resumes
  Future<List<ResumeForm>> getResumes(bool ascending) async {
    try {
      QuerySnapshot querySnapshot = await _resumeCollection.get();
      List<ResumeForm> resumes = [];
      for (var doc in querySnapshot.docs) {
        resumes.add(ResumeForm.fromJson(doc.data() as Map<String, dynamic>));
      }
      if (ascending) {
        resumes.sort((a, b) => a.createdDate.compareTo(b.createdDate));
      } else {
        resumes.sort((a, b) => b.createdDate.compareTo(a.createdDate));
      }
      return resumes;
      // QuerySnapshot querySnapshot = await _resumeCollection.get();
      // List<ResumeForm> resumes = [];
      // for (var doc in querySnapshot.docs) {
      //   resumes.add(ResumeForm.fromJson(doc.data() as Map<String, dynamic>));
      // }
      // return resumes;
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  // Get resume
  Future<DocumentSnapshot> getResume(String resumeId) async {
    try {
      return _resumeCollection.doc(resumeId).get();
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  // Add resume
  Future<String> addResume(Map<String, dynamic> data, String id) async {
    if (id == '0') {
      try {
        // create id
        String resumeId = _resumeCollection.doc().id;
        data['id'] = resumeId;
        await _resumeCollection.doc(resumeId).set(data);
        return 'SUCCESS';
      } on FirebaseException catch (e) {
        return e.message.toString();
      }
    } else {
      try {
        await _resumeCollection.doc(id).set(data, SetOptions(merge: true));
        return 'SUCCESS';
      } on FirebaseException catch (e) {
        return e.message.toString();
      }
    }
  }

  // Delete resume
  Future<void> deleteResume(String resumeId) async {
    try {
      await _resumeCollection.doc(resumeId).delete();
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }
}
