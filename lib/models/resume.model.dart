class ResumeForm {
  late String id;
  late String name;
  late String email;
  late String phone;
  late String createdBy;
  late String address;
  late String city;
  late String state;
  late String zip;
  late String country;
  late String objective;
  late List<String> skills;
  late List<Education> educationList;
  late List<Experience> experienceList;
  late DateTime createdDate;

  ResumeForm({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdBy,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.objective,
    required this.skills,
    required this.educationList,
    required this.experienceList,
    required this.createdDate,
  });

// from json
  factory ResumeForm.fromJson(Map<String, dynamic> json) {
    return ResumeForm(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      createdBy: json['createdBy'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      country: json['country'],
      objective: json['objective'],
      skills: json['skills'].cast<String>(),
      educationList: json['educationList']
          .map<Education>((education) => Education.fromJson(education))
          .toList(),
      experienceList: json['experienceList']
          .map<Experience>((experience) => Experience.fromJson(experience))
          .toList(),
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

// to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['createdBy'] = createdBy;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
    data['objective'] = objective;
    data['skills'] = skills;
    data['educationList'] = educationList.map((v) => v.toJson()).toList();
    data['experienceList'] = experienceList.map((v) => v.toJson()).toList();
    data['createdDate'] = createdDate.toIso8601String();
    return data;
  }
}

class Education {
  late String degree;
  late String major;
  late String institution;
  late String location;
  late String graduationYear;

  Education({
    required this.degree,
    required this.major,
    required this.institution,
    required this.location,
    required this.graduationYear,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'],
      major: json['major'],
      institution: json['institution'],
      location: json['location'],
      graduationYear: json['graduationYear'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['degree'] = degree;
    data['major'] = major;
    data['institution'] = institution;
    data['location'] = location;
    data['graduationYear'] = graduationYear;
    return data;
  }
}

class Experience {
  late String jobTitle;
  late String companyName;
  late String location;
  late String startDate;
  late String endDate;
  late String description;

  Experience({
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      jobTitle: json['jobTitle'],
      companyName: json['companyName'],
      location: json['location'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobTitle'] = jobTitle;
    data['companyName'] = companyName;
    data['location'] = location;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['description'] = description;
    return data;
  }
}
