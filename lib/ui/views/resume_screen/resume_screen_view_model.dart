import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/core/route_constants.dart';
import 'package:resume_builder/models/resume.model.dart';
import 'package:resume_builder/services/firebase_resume_service.dart';
import 'package:resume_builder/ui/widgets/toaster.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ResumeScreenViewModel extends BaseViewModel {
  final BuildContext context;
  // final ResumeForm resumeForm;
  ResumeScreenViewModel({required this.context});

  bool isLoading = false;

  ResumeForm resumeForm = ResumeForm(
    id: '',
    name: '',
    email: '',
    phone: '',
    createdBy: '',
    address: '',
    city: '',
    state: '',
    zip: '',
    country: '',
    objective: '',
    skills: [],
    educationList: [
      Education(
        degree: '',
        major: '',
        institution: '',
        location: '',
        graduationYear: '',
      ),
    ],
    experienceList: [
      Experience(
        jobTitle: '',
        companyName: '',
        location: '',
        startDate: '',
        endDate: '',
        description: '',
      ),
    ],
    createdDate: DateTime.now(),
  );

  Future<DocumentSnapshot> getResume(String resumeId) async {
    return FirebaseResumeService().getResume(resumeId);
  }

  // Add Education
  void addEducation() {
    resumeForm.educationList.add(
      Education(
        degree: '',
        major: '',
        institution: '',
        location: '',
        graduationYear: '',
      ),
    );
    notifyListeners();
  }

  // Remove Education
  void removeEducation() {
    resumeForm.educationList.removeLast();
    notifyListeners();
  }

  // Add Experience
  void addExperience() {
    resumeForm.experienceList.add(
      Experience(
        jobTitle: '',
        companyName: '',
        location: '',
        startDate: '',
        endDate: '',
        description: '',
      ),
    );
    notifyListeners();
  }

  // Remove Experience
  void removeExperience() {
    resumeForm.experienceList.removeLast();
    notifyListeners();
  }

  // Add Skill
  void addSkill() {
    resumeForm.skills.add('');
    notifyListeners();
  }

  // Remove Skill
  void removeSkill() {
    resumeForm.skills.removeLast();
    notifyListeners();
  }

  Future<String> datePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    ).then((date) {
      if (date != null) {
        return DateFormat('dd-MM-yyyy').format(date).toString();
      } else {
        return "";
      }
    });
  }

  void updateIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  // Save Resume
  Future saveResume(String id) async {
    updateIsLoading();
    await addResume(resumeForm, id).then((flag) {
      if (flag == 'SUCCESS') {
        buildToaster(message: 'Resume Saved Successfully');
        // nevigate to home screen
        Navigator.pushReplacementNamed(context, homeScreen);
      } else if (flag != '') {
        buildToaster(message: flag);
      } else {
        buildToaster(message: 'Something went wrong');
      }
    });
    updateIsLoading();
  }

  // Add Resume
  Future addResume(ResumeForm resume, String id) async {
    return FirebaseResumeService().addResume(resume.toJson(), id);
  }
}
