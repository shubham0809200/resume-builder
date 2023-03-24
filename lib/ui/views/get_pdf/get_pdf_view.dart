import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:resume_builder/models/resume.model.dart';
import 'package:resume_builder/ui/widgets/toaster.dart';
import 'package:stacked/stacked.dart';

import 'get_pdf_view_model.dart';

part 'get_pdf_mobile.dart';

class GetPdfView extends StatelessWidget {
  final ResumeForm resume;
  const GetPdfView({Key? key, required this.resume}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GetPdfViewModel>.reactive(
        viewModelBuilder: () => GetPdfViewModel(
              context: context,
              resumeForm: resume,
        ),
        // onModelReady: (model) {
        //   // Do Something on Model Ready
        // },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _GetPdfMobile(
            viewModel: model,
          ));
        });
  }
}
