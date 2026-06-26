import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GeneratePdfScreen extends StatefulWidget {
  const GeneratePdfScreen({super.key});

  @override
  State<GeneratePdfScreen> createState() => _GeneratePdfScreenState();
}

class _GeneratePdfScreenState extends State<GeneratePdfScreen> {
  // String? _logo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Reader')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              generatePdf();
            },
            child: Text('Gererate PDF File'),
          ),
        ],
      ),
    );
  }

  Future generatePdf() async {
    // _logo = await rootBundle.loadString('assets/logo.svg');

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World", style: pw.TextStyle(fontSize: 50)),
          ); // Center
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    final file = File("example.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
