import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_maker/form_maker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:resume_builder/core/route_constants.dart';
import 'package:resume_builder/models/resume.model.dart';
import 'package:resume_builder/ui/widgets/single_input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'resume_screen_view_model.dart';

part 'resume_screen_mobile.dart';

class ResumeScreenView extends StatelessWidget {
  final String resumeId;
  const ResumeScreenView({Key? key, required this.resumeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResumeScreenViewModel>.nonReactive(
        viewModelBuilder: () => ResumeScreenViewModel(
              context: context,
            ),
        // onModelReady: (model) {
        //   // Do Something on Model Ready
        // },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _ResumeScreenMobile(
            resumeId: resumeId,
            viewModel: model,
          ));
        });
  }
}
