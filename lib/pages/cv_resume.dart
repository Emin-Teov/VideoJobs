import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import '/pages/get_text_field.dart';

class CVResume extends StatefulWidget {
  final int id;
  final String username;
  final int index;

  const CVResume({
    super.key,
    required this.id,
    required this.username,
    required this.index,
  });

  @override
  State<CVResume> createState() => _CVResumeState();
}

class _CVResumeState extends State<CVResume> {
  List<String> _pdf_url = [
    'cv_resume',
    'description',
    'freelancer_resume',
    'poster'
  ];

  @override
  Widget build(BuildContext context) {
    String _title = widget.username.replaceAll(' ', '_');

    Future<void> loadPdf() async {
      final String url = 'https://emin-teov.github.io/api/pdf/${_pdf_url[widget.index]}-${widget.id}.pdf';
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final Directory? _dir = await getDownloadsDirectory();
      final file = File('${_dir?.absolute.path}/${_title}.pdf');
      print('File: ${file}');
      await file.writeAsBytes(bytes, flush: true);
      await OpenFile.open('${_dir?.absolute.path}/${_title}.pdf');
    }

    return Scaffold(
      appBar: AppBar(
        title: GetTextField(
          text: widget.username,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.download,
            ),
            onPressed: loadPdf,
          ),
        ],
      ),
      body: Container(
        child: SfPdfViewer.network('https://emin-teov.github.io/api/pdf/${_pdf_url[widget.index]}-${widget.id}.pdf'),
      ),
    );
  }
}
