part of 'signin_screen_view.dart';

class _SigninScreenMobile extends StatelessWidget {
  final SigninScreenViewModel viewModel;

  const _SigninScreenMobile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return Builder(
        builder: (context) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(viewModel.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0C54BE),
                      )),
                  backgroundColor: Colors.transparent,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Flexible(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Email
                                buildTextField(
                                    title: 'Email',
                                    hintText: 'Enter your email',
                                    controller: TextEditingController(
                                        text: viewModel.emailId),
                                    onChanged: (value) {
                                      viewModel.emailId = value;
                                    },
                                    textInputType: TextInputType.emailAddress),
                                const SizedBox(height: 19),
                                // Password
                                buildTextField(
                                    title: 'Password',
                                    hintText: 'Enter your password',
                                    obscureText: true,
                                    controller: TextEditingController(
                                        text: viewModel.password),
                                    onChanged: (value) {
                                      viewModel.password = value;
                                    },
                                    textInputType:
                                        TextInputType.visiblePassword),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.updateIsLoading();
                                    viewModel.signInUser().then((flag) {
                                      if (flag == 'EMPTY') {
                                        buildToaster(
                                            message:
                                                'Email and Password Can\'t be $flag',
                                            color: Colors.red);
                                      } else if (flag == '') {
                                        buildToaster(message: flag);
                                      } else if (flag == 'SUCCESS') {
                                        Navigator.pushReplacementNamed(
                                            context, homeScreen);
                                      } else {
                                        buildToaster(
                                            message: 'Error in Authentication',
                                            color: Colors.red);
                                      }
                                      viewModel.updateIsLoading();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF0C54BE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: viewModel.isLoading
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white))
                                      : Text('Login',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFFFFFFF),
                                          )),
                                ),
                              ),
                              const SizedBox(height: 9),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('New here?',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF000000),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, signUpScreen);
                                    },
                                    child: Text('Signup',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0C54BE),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }
}
