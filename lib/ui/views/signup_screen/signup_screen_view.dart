import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_builder/core/route_constants.dart';
import 'package:resume_builder/ui/widgets/toaster.dart';
import 'package:resume_builder/ui/widgets/single_input_field.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'signup_screen_view_model.dart';

part 'signup_screen_mobile.dart';

class SignupScreenView extends StatelessWidget {
  const SignupScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupScreenViewModel>.reactive(
        viewModelBuilder: () => SignupScreenViewModel(),
        // onModelReady: (model) {
        //   // Do Something on Model Ready
        // },
        builder: (context, model, child) {
          return ScreenTypeLayout(
              mobile: _SignupScreenMobile(
            viewModel: model,
          ));
        });
  }
}
