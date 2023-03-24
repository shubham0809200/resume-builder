import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_builder/core/route_constants.dart';
import 'package:resume_builder/models/article.model.dart';
import 'package:resume_builder/models/resume.model.dart';
import 'package:resume_builder/res/imp_data.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:resume_builder/ui/views/get_pdf/get_pdf_view.dart';
import 'package:resume_builder/ui/views/resume_screen/resume_screen_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'home_screen_view_model.dart';

part 'home_screen_mobile.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        // onModelReady: (model) {
        //   // Do Something on Model Ready
        // },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _HomeScreenMobile(
            viewModel: model,
          ));
        });
  }
}
