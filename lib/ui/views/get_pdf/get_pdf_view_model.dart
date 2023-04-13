import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resume_builder/models/resume.model.dart';
import 'package:stacked/stacked.dart';

// printing
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GetPdfViewModel extends BaseViewModel {
  final BuildContext context;
  final ResumeForm resumeForm;
  GetPdfViewModel({required this.context, required this.resumeForm});

  Future<File> generate() async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          child: pw.Text(
            'Resume Builder',
            style: pw.Theme.of(context)
                .defaultTextStyle
                .copyWith(color: PdfColors.grey),
          ),
        );
      },
      footer: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.Theme.of(context)
                .defaultTextStyle
                .copyWith(color: PdfColors.grey),
          ),
        );
      },
      build: (pw.Context context) => <pw.Widget>[
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            // show name in bottom left
            name(),
            // show address
            address(context),
          ],
        ),
        pw.SizedBox(height: 20),
        // Objective
        objectiveSummary(context),
        seperator(),
        pw.SizedBox(height: 10),

        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            // show education
            if (resumeForm.educationList.isNotEmpty)
              pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 5.0),
                  child: education()),
            if (resumeForm.skills.isNotEmpty) skills(),
          ],
        ),

        pw.SizedBox(height: 20),
        if (resumeForm.experienceList.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 10.0),
            child: experience(),
          ),

        pw.SizedBox(height: 20),
      ],
    ));

    // Printing
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    return saveDocument(name: 'example.pdf', pdf: pdf);
  }

  pw.Container seperator() {
    return pw.Container(
      height: 1,
      color: PdfColors.grey,
    );
  }

  pw.Column skills() {
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Header(
            level: 1,
            child: pw.Text('Skills'),
          ),
          pw.SizedBox(height: 10),
          for (var skill in resumeForm.skills)
            pw.Text("* $skill",
                textScaleFactor: 1.2,
                textAlign: pw.TextAlign.left,
                style: const pw.TextStyle(color: PdfColors.black)),
        ]);
  }

  pw.Column education() {
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Header(
            level: 1,
            child: pw.Text('Education'),
          ),
          pw.SizedBox(height: 10),
          for (var education in resumeForm.educationList)
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(education.degree),
                          pw.Text("- ${education.graduationYear}",
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.grey)),
                        ]),
                    pw.Row(children: [
                      pw.Text(education.major),
                      pw.Text('- ${education.institution}',
                          style: const pw.TextStyle(color: PdfColors.grey)),
                    ]),
                    pw.Text(education.location),
                  ]),
            ),
        ]);
  }

  pw.Column experience() {
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Header(
            level: 1,
            child: pw.Text('Experience'),
          ),
          pw.SizedBox(height: 10),
          for (var experience in resumeForm.experienceList)
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(experience.jobTitle),
                          pw.Text(
                              "- ${experience.startDate} - ${experience.endDate}",
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.grey)),
                        ]),
                    pw.Row(children: [
                      pw.Text(experience.companyName),
                      pw.Text('- ${experience.location}',
                          style: const pw.TextStyle(color: PdfColors.grey)),
                    ]),
                    pw.Text(experience.description),
                  ]),
            ),
        ]);
  }

  pw.Column objectiveSummary(pw.Context context) {
    return pw.Column(children: [
      pw.Header(
        level: 0,
        child: pw.Text(
          'SUMMARY',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
      pw.Paragraph(
        text: resumeForm.objective,
        style: pw.Theme.of(context)
            .defaultTextStyle
            .copyWith(color: PdfColors.grey),
      ),
    ]);
  }

  pw.Text name() {
    return pw.Text(
      resumeForm.name,
      style: pw.TextStyle(
        fontSize: 20,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }

  pw.Column address(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: <pw.Widget>[
        pw.Text(
          resumeForm.email,
          style: pw.Theme.of(context)
              .defaultTextStyle
              .copyWith(color: PdfColors.grey),
        ),
        pw.Text(
          resumeForm.phone,
          style: pw.Theme.of(context)
              .defaultTextStyle
              .copyWith(color: PdfColors.grey),
        ),
        // show address divided in few lines
        pw.SizedBox(
          height: 30,
          width: 200,
          child: pw.Text(
            resumeForm.address,
            textAlign: pw.TextAlign.right,
            style: pw.Theme.of(context)
                .defaultTextStyle
                .copyWith(color: PdfColors.grey),
          ),
        ),
      ],
    );
  }

  Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }
}
