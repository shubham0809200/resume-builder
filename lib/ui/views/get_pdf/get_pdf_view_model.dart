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
        // if (context.pageNumber == 1) {
        //   return null;
        // }
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          // decoration: const pw.BoxDecoration(
          //   border: pw.BoxBorder(
          //     bottom: true,
          //     width: 0.5,
          //     color: PdfColors.grey,
          //   ),
          // ),
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
            pw.Text(
              resumeForm.name,
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            // show address
            pw.Column(
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
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Header(
          level: 0,
          child: pw.Text(
            'Objective',
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
        if (resumeForm.educationList.isNotEmpty)
          pw.Text(
            'Education',
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        if (resumeForm.educationList.isNotEmpty)
          pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
              },
              tableWidth: pw.TableWidth.max,
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Degree',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Institute',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Year',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ]),
              ]),
        for (var i = 0; i < resumeForm.educationList.length; i++)
          pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
              },
              tableWidth: pw.TableWidth.max,
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(resumeForm.educationList[i].degree),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(resumeForm.educationList[i].institution),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(resumeForm.educationList[i].graduationYear),
                  ),
                ]),
              ]),
        pw.SizedBox(height: 20),
        if (resumeForm.experienceList.isNotEmpty)
          pw.Text(
            'Experience',
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        if (resumeForm.experienceList.isNotEmpty)
          pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
              },
              tableWidth: pw.TableWidth.max,
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Company',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Position',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Year',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ]),
              ]),
        for (var i = 0; i < resumeForm.experienceList.length; i++)
          pw.Table(
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
              },
              tableWidth: pw.TableWidth.max,
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(resumeForm.experienceList[i].companyName),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(resumeForm.experienceList[i].jobTitle),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                        '${resumeForm.experienceList[i].startDate} - ${resumeForm.experienceList[i].endDate}'),
                  ),
                ]),
              ]),
        pw.SizedBox(height: 20),
        if (resumeForm.skills.isNotEmpty)
          pw.Text(
            'Skills',
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        if (resumeForm.skills.isNotEmpty)
          pw.Wrap(children: [
            pw.Row(children: [
              for (var i = 0; i < resumeForm.skills.length; i++)
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(resumeForm.skills[i]),
                ),
            ]),
          ]),
      ],
    ));

    // Printing
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    return saveDocument(name: 'example.pdf', pdf: pdf);
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
