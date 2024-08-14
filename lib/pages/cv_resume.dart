import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class CVResume extends StatefulWidget {
  final int id;
  final String job_seeker;

  const CVResume({super.key, required this.id, required this.job_seeker});

  @override
  State<CVResume> createState() => _CVResumeState();
}

class _CVResumeState extends State<CVResume> {
  @override
  Widget build(BuildContext context) {
    String _title = widget.job_seeker.split(' ')[0];

    Future<void> loadPdf() async {
      final String url = 'https://emin-teov.github.io/api/resume/cv_resume-${widget.id}.pdf';
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final Directory? _dir = await getDownloadsDirectory();
      final file = File('${_dir?.absolute.path}/${_title}.pdf');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('${_dir?.absolute.path}/${_title}.pdf');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.black,
            ),
            onPressed: loadPdf,
          ),
        ],
      ),
      body: Container(
        child: SfPdfViewer.network(
            'https://emin-teov.github.io/api/resume/cv_resume-${widget.id}.pdf'),
      ),
    );
  }
}
