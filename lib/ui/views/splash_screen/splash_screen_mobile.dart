part of 'splash_screen_view.dart';

class _SplashScreenMobile extends StatelessWidget {
  final SplashScreenViewModel viewModel;

  const _SplashScreenMobile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
