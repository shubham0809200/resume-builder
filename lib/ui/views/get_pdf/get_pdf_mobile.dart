part of 'get_pdf_view.dart';

class _GetPdfMobile extends StatelessWidget {
  final GetPdfViewModel viewModel;

  const _GetPdfMobile({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get PDF'),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // make a button
            ElevatedButton(
              onPressed: () async {
                try {
                  final pdf = await viewModel.generate();
                  final url = pdf.path;
                  await OpenFile.open(url);
                } catch (e) {
                  buildToaster(message: e.toString());
                }
              },
              child: const Text('Generate PDF'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
