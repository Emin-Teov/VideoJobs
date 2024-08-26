import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
import 'package:video_list/pages/get_text_field.dart';

class CVResume extends StatefulWidget {
  final int id;
  final String job_seeker;
  final bool freelancer;

  const CVResume(
      {super.key,
      required this.id,
      required this.job_seeker,
      required this.freelancer});

  @override
  State<CVResume> createState() => _CVResumeState();
}

class _CVResumeState extends State<CVResume> {
  @override
  Widget build(BuildContext context) {
    String _title = widget.job_seeker.split(' ')[0];

    Future<void> loadPdf() async {
      final String url =
          'https://emin-teov.github.io/api/resume/${widget.freelancer ? 'freelancer' : 'cv'}_resume-${widget.id}.pdf';
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final Directory? _dir = await getDownloadsDirectory();
      final file = File('${_dir?.absolute.path}/${_title}.pdf');
      print('File: ${file}');
      await file.writeAsBytes(bytes, flush: true);
      await OpenFile.open('${_dir?.absolute.path}/${_title}.pdf');
      // OpenFile.open('${_dir?.absolute.path}/${_title}.pdf');
    }

    return Scaffold(
      appBar: AppBar(
        title: GetTextField(
          text: _title,
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
        child: SfPdfViewer.network(
            'https://emin-teov.github.io/api/resume/${widget.freelancer ? 'freelancer' : 'cv'}_resume-${widget.id}.pdf'),
      ),
    );
  }
}
