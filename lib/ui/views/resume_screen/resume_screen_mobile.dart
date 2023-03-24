part of 'resume_screen_view.dart';

class _ResumeScreenMobile extends StatelessWidget {
  final ResumeScreenViewModel viewModel;
  final String resumeId;

  const _ResumeScreenMobile(
      {Key? key, required this.viewModel, required this.resumeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C54BE),
        title: Text('Resume',
            style: GoogleFonts.poppins(
              height: 2.5,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF5F9FD),
            )),
        elevation: 0,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Builder(
      builder: (context) {
        return SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
            future: viewModel.getResume(resumeId),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot?> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Something went wrong: ${snapshot.error.toString()}"),
                ));
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return ResumeFormSection(
                  resumeForm: viewModel.resumeForm,
                  viewModel: viewModel,
                  resumeId: resumeId,
                );
              }

              // wait for data to load
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 190, 12, 56),
                ));
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                // add all date to resume
                viewModel.resumeForm = ResumeForm.fromJson(data);

                return ResumeFormSection(
                  resumeForm: viewModel.resumeForm,
                  viewModel: viewModel,
                  resumeId: resumeId,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}

class ResumeFormSection extends HookViewModelWidget<ResumeScreenViewModel> {
  final ResumeForm resumeForm;
  final ResumeScreenViewModel viewModel;
  final String resumeId;
  const ResumeFormSection(
      {Key? key,
      required this.resumeForm,
      required this.viewModel,
      required this.resumeId})
      : super(key: key);
  @override
  Widget buildViewModelWidget(
      BuildContext context, ResumeScreenViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _questionOne(context),
            const SizedBox(height: 16),
            _questionTwo(context),
            const SizedBox(height: 16),
            _questionThree(context),
            const SizedBox(height: 16),
            _questionFour(context),
            const SizedBox(height: 16),
            _questionFive(context),
            const SizedBox(height: 16),
            _questionSix(context),
            const SizedBox(height: 16),
            _questionSeven(context),
            const SizedBox(height: 16),
            _questionEight(context),
            const SizedBox(height: 16),
            _questionNine(context),
            const SizedBox(height: 16),
            _questionTen(context),
            const SizedBox(height: 16),
            _questionEleven(context),
            const SizedBox(height: 16),
            _questionTwelve(context),
            const SizedBox(height: 16),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await viewModel.saveResume(resumeId);
                  },
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Name
  _questionOne(BuildContext context) {
    return FormElement.name(
      controller: TextEditingController(text: viewModel.resumeForm.name),
      onChanged: ((value) {
        viewModel.resumeForm.name = value;
      }),
    );
  }

  // Email
  _questionTwo(BuildContext context) {
    return FormElement.email(
      controller: TextEditingController(text: viewModel.resumeForm.email),
      onChanged: ((value) {
        viewModel.resumeForm.email = value;
      }),
    );
  }

  // Phone
  _questionThree(BuildContext context) {
    return FormElement.phone(
      controller: TextEditingController(text: viewModel.resumeForm.phone),
      onChanged: ((value) {
        viewModel.resumeForm.phone = value;
      }),
    );
  }

  // Address
  _questionFour(BuildContext context) {
    return FormElement.address(
      controller: TextEditingController(text: viewModel.resumeForm.address),
      onChanged: ((value) {
        viewModel.resumeForm.address = value;
      }),
    );
  }

  // City
  _questionFive(BuildContext context) {
    return FormElement.city(
      controller: TextEditingController(text: viewModel.resumeForm.city),
      onChanged: ((value) {
        viewModel.resumeForm.city = value;
      }),
    );
  }

  // State
  _questionSix(BuildContext context) {
    return FormElement.state(
      controller: TextEditingController(text: viewModel.resumeForm.state),
      onChanged: ((value) {
        viewModel.resumeForm.state = value;
      }),
    );
  }

  // Zip
  _questionSeven(BuildContext context) {
    return FormElement.zip(
      controller: TextEditingController(text: viewModel.resumeForm.zip),
      onChanged: ((value) {
        viewModel.resumeForm.zip = value;
      }),
    );
  }

  // Country
  _questionEight(BuildContext context) {
    return FormElement.country(
      controller: TextEditingController(text: viewModel.resumeForm.country),
      onChanged: ((value) {
        viewModel.resumeForm.country = value;
      }),
    );
  }

  // Objective
  _questionNine(BuildContext context) {
    return FormElement.custom(
      label: "Answer",
      title: 'Objective',
      hint: 'Objective',
      maxLines: 4,
      textInputType: TextInputType.name,
      controller: TextEditingController(text: viewModel.resumeForm.objective),
      onChanged: ((value) {
        viewModel.resumeForm.objective = value;
      }),
    );
  }

  // Skills
  _questionTen(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text("Skills",
                      style: Theme.of(context).textTheme.titleMedium))
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: viewModel.resumeForm.skills.length,
            itemBuilder: (context, index) {
              return _skillsItem(index, context);
            },
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            InkWell(
              onTap: () {
                viewModel.addSkill();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            if (viewModel.resumeForm.skills.length > 1)
              InkWell(
                onTap: () {
                  viewModel.removeSkill();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Remove',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
          ]),
        ],
      ),
    );
  }

  // Skill Items
  _skillsItem(int index, BuildContext context) {
    return Column(
      children: [
        buildTextFieldWithoutLabel(
          controller:
              TextEditingController(text: viewModel.resumeForm.skills[index]),
          onChanged: ((value) {
            viewModel.resumeForm.skills[index] = value;
          }),
          hintText: 'Skill ${index + 1}',
          labelText: 'Skill ${index + 1}',
        ),
        const SizedBox(height: 15),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // Education
  _questionEleven(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text("Education",
                      style: Theme.of(context).textTheme.titleMedium))
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: viewModel.resumeForm.educationList.length,
            itemBuilder: (context, index) {
              return _educationItem(index, context);
            },
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            InkWell(
              onTap: () {
                viewModel.addEducation();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            if (viewModel.resumeForm.educationList.length > 1)
              InkWell(
                onTap: () {
                  viewModel.removeEducation();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Remove',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
          ])
        ],
      ),
    );
  }

  // Education Item
  _educationItem(int index, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: buildTextFieldWithoutLabel(
              controller: TextEditingController(
                  text: viewModel.resumeForm.educationList[index].degree),
              onChanged: ((value) {
                viewModel.resumeForm.educationList[index].degree = value;
              }),
              hintText: "B.Tech",
              labelText: "Degree",
            )),
            const SizedBox(width: 8),
            Flexible(
              child: buildTextFieldWithoutLabel(
                controller: TextEditingController(
                    text: viewModel
                        .resumeForm.educationList[index].graduationYear),
                onChanged: ((value) {
                  viewModel.resumeForm.educationList[index].graduationYear =
                      value;
                }),
                hintText: "2020",
                labelText: "Graduation Year",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        buildTextFieldWithoutLabel(
          controller: TextEditingController(
              text: viewModel.resumeForm.educationList[index].major),
          onChanged: ((value) {
            viewModel.resumeForm.educationList[index].major = value;
          }),
          hintText: "Computer Science",
          labelText: "Major",
        ),
        const SizedBox(height: 20),
        buildTextFieldWithoutLabel(
          controller: TextEditingController(
              text: viewModel.resumeForm.educationList[index].institution),
          onChanged: ((value) {
            viewModel.resumeForm.educationList[index].institution = value;
          }),
          hintText: "University of California",
          labelText: "Institution",
        ),
        const SizedBox(height: 20),
        buildTextFieldWithoutLabel(
          controller: TextEditingController(
              text: viewModel.resumeForm.educationList[index].location),
          onChanged: ((value) {
            viewModel.resumeForm.educationList[index].location = value;
          }),
          hintText: "California",
          labelText: "Location",
        ),
        const SizedBox(height: 20),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Work Experience
  _questionTwelve(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text("Work Experience",
                      style: Theme.of(context).textTheme.titleMedium))
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: viewModel.resumeForm.experienceList.length,
            itemBuilder: (context, index) {
              return _experienceItem(index, context);
            },
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            InkWell(
              onTap: () {
                viewModel.addExperience();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            if (viewModel.resumeForm.experienceList.length > 1)
              InkWell(
                onTap: () {
                  viewModel.removeExperience();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Remove',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
          ])
        ],
      ),
    );
  }

  // Work Experience Item
  _experienceItem(int index, BuildContext context) {
    return Column(
      children: [
        buildTextFieldWithoutLabel(
          controller: TextEditingController(
              text: viewModel.resumeForm.experienceList[index].jobTitle),
          textInputType: TextInputType.text,
          onChanged: ((value) {
            viewModel.resumeForm.experienceList[index].jobTitle = value;
          }),
          hintText: 'Job Title',
          labelText: 'Job Title',
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Flexible(
              child: buildTextFieldWithoutLabel(
                controller: TextEditingController(
                    text: viewModel.resumeForm.experienceList[index].startDate),
                textInputType: TextInputType.datetime,
                onChanged: ((value) {
                  viewModel.resumeForm.experienceList[index].startDate = value;
                }),
                onTap: () {
                  viewModel.datePicker(context).then((value) {
                    viewModel.resumeForm.experienceList[index].startDate =
                        value;
                    viewModel.notifyListeners();
                  });
                },
                hintText: 'start date',
                labelText: 'start date',
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: buildTextFieldWithoutLabel(
                controller: TextEditingController(
                    text: viewModel.resumeForm.experienceList[index].endDate),
                textInputType: TextInputType.datetime,
                onChanged: ((value) {
                  viewModel.resumeForm.experienceList[index].endDate = value;
                }),
                onTap: () {
                  viewModel.datePicker(context).then((value) {
                    viewModel.resumeForm.experienceList[index].endDate = value;
                    viewModel.notifyListeners();
                  });
                },
                hintText: 'end date',
                labelText: 'end date',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        buildTextFieldWithoutLabel(
          controller: TextEditingController(
              text: viewModel.resumeForm.experienceList[index].companyName),
          textInputType: TextInputType.text,
          onChanged: ((value) {
            viewModel.resumeForm.experienceList[index].companyName = value;
          }),
          hintText: 'Company Name',
          labelText: 'Company Name',
        ),
        const SizedBox(height: 20),
        buildTextFieldWithoutLabel(
          controller: TextEditingController(
              text: viewModel.resumeForm.experienceList[index].location),
          textInputType: TextInputType.text,
          onChanged: ((value) {
            viewModel.resumeForm.experienceList[index].location = value;
          }),
          hintText: 'Location',
          labelText: 'Location',
        ),
        const SizedBox(height: 20),
        buildTextFieldWithoutLabel(
          controller: TextEditingController(
              text: viewModel.resumeForm.experienceList[index].description),
          textInputType: TextInputType.text,
          onChanged: ((value) {
            viewModel.resumeForm.experienceList[index].description = value;
          }),
          hintText: 'Job Description',
          labelText: 'Job Description',
        ),
        const SizedBox(height: 20),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
