part of 'signup_screen_view.dart';

class _SignupScreenMobile extends StatelessWidget {
  final SignupScreenViewModel viewModel;

  const _SignupScreenMobile({Key? key, required this.viewModel})
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
                  title: Text(
                    viewModel.title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0C54BE),
                    ),
                  ),
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
                                    title: 'Name',
                                    hintText: 'Enter your name',
                                    controller: TextEditingController(
                                        text: viewModel.user.name),
                                    onChanged: (value) {
                                      viewModel.user.name = value;
                                    },
                                    textInputType: TextInputType.emailAddress),
                                const SizedBox(height: 20),
                                buildTextField(
                                    title: 'Email',
                                    hintText: 'Enter your email',
                                    controller: TextEditingController(
                                        text: viewModel.user.email),
                                    onChanged: (value) {
                                      viewModel.user.email = value;
                                    },
                                    textInputType: TextInputType.emailAddress),
                                const SizedBox(height: 20),
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
                              // Sign in button
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
                                                'Please fill all the fields',
                                            color: Colors.red);
                                      } else if (flag == 'SUCCESS') {
                                        Navigator.pushReplacementNamed(
                                            context, homeScreen);
                                      } else if (flag == '') {
                                        buildToaster(
                                            message: flag, color: Colors.red);
                                      } else {
                                        buildToaster(
                                            message: 'Erro in Authentication',
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
                                      : Text('Signup',
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
                                  Text('Already have an account?',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF000000),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, signInScreen);
                                    },
                                    child: Text('Login',
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
