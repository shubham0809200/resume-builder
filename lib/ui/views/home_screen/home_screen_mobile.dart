part of 'home_screen_view.dart';

class _HomeScreenMobile extends StatelessWidget {
  final HomeScreenViewModel viewModel;

  const _HomeScreenMobile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FD),

      // floatingActionButton to add new resume
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, resumeScreen,
              arguments: const ResumeScreenView(resumeId: '0'));
        },
        backgroundColor: const Color(0xFF0C54BE),
        child: const Icon(Icons.add),
      ),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0C54BE),
        title: Text('Resumes',
            style: GoogleFonts.poppins(
              height: 2.5,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF5F9FD),
            )),
        actions: [
          Row(
            children: [
              // make a button
              IconButton(
                onPressed: () {
                  _showDialog(context, viewModel);
                },
                icon: const Icon(Icons.logout),
                color: const Color(0xFFF5F9FD),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Builder(
        builder: (context) => SafeArea(
                child: FutureBuilder(
              future: viewModel.getResumes(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ResumeForm>?> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.hasData && snapshot.data != null) {
                  return HomeScreenListView(
                      resumes: snapshot.data!, viewModel: viewModel);
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data as Map<String, dynamic>;
                  // add all date to article
                  data.forEach((key, value) {
                    ResumeForm resume = ResumeForm.fromJson(value);
                    viewModel.resumes.add(resume);
                  });
                  return HomeScreenListView(
                      resumes: viewModel.resumes, viewModel: viewModel);
                }

                return const Center(child: Text("loading..."));
              },
            )));
  }

  _showDialog(BuildContext context, HomeScreenViewModel viewModel) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout User',
              style: GoogleFonts.poppins(
                height: 2.5,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0C54BE),
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?',
                    style: GoogleFonts.poppins(
                      height: 2.5,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000000),
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No',
                  style: GoogleFonts.poppins(
                    height: 2.5,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0C54BE),
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes',
                  style: GoogleFonts.poppins(
                    height: 2.5,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 190, 54, 12),
                  )),
              onPressed: () {
                viewModel.signOutUser().then((value) {
                  Navigator.pushReplacementNamed(
                    context,
                    signInScreen,
                  );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// ignore: deprecated_member_use
class HomeScreenListView extends HookViewModelWidget<HomeScreenViewModel> {
  final List<ResumeForm> resumes;
  final HomeScreenViewModel viewModel;

  const HomeScreenListView(
      {Key? key, required this.resumes, required this.viewModel})
      : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, HomeScreenViewModel model) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        viewModel.getResumes();
        viewModel.notifyListeners();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            actions: [
              IconButton(
                  onPressed: () {
                    viewModel.isAscending = !viewModel.isAscending;
                    viewModel.notifyListeners();
                  },
                  icon: const Icon(Icons.arrow_upward))
            ],
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: resumes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // navigate to resume screen
                        Navigator.pushNamed(context, resumeScreen,
                            arguments:
                                ResumeScreenView(resumeId: resumes[index].id));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 10, top: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(resumes[index].name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF000000),
                                        )),
                                    const SizedBox(height: 10),
                                    Text(resumes[index].email,
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF000000),
                                        ).copyWith(
                                            overflow: TextOverflow.ellipsis)),
                                    const SizedBox(height: 10),
                                    Text(
                                        'Created on : ${viewModel.formatDate(resumes[index].createdDate)}',
                                        style: GoogleFonts.poppins(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFFCED3DC),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              // view resume
                              IconButton(
                                  onPressed: () {
                                    // navigate to resume screen
                                    Navigator.pushNamed(
                                      context,
                                      getPdf,
                                      arguments: GetPdfView(
                                        resume: resumes[index],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.visibility)),
                              // delete resume
                              IconButton(
                                  onPressed: () {
                                    // take confirmation
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Delete Resume',
                                                style: GoogleFonts.poppins(
                                                  height: 2.5,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      const Color(0xFF0C54BE),
                                                )),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                      'Are you sure you want to delete this resume?',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        height: 2.5,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xFF000000),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('No',
                                                    style: GoogleFonts.poppins(
                                                      height: 2.5,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                          0xFF0C54BE),
                                                    )),
                                                onPressed: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, homeScreen);
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Yes',
                                                    style: GoogleFonts.poppins(
                                                      height: 2.5,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 190, 54, 12),
                                                    )),
                                                onPressed: () {
                                                  viewModel
                                                      .deleteResume(
                                                          resumes[index].id)
                                                      .then((value) {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            homeScreen);
                                                    // refresh the list
                                                    viewModel.getResumes();
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
