import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/get_text_label.dart';
import 'package:video_list/pages/video_items.dart';

class OfferItem extends StatefulWidget {
  final int id;
  final String tittle;
  final int employer_id;
  final String employer;
  final bool video;
  final String description;
  final List data;

  const OfferItem({
    super.key,
    required this.id,
    required this.tittle,
    required this.employer_id,
    required this.employer,
    required this.video,
    required this.description,
    required this.data,
  });

  @override
  State<OfferItem> createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem> {
  late List _get_data = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.data.length; i++) {
      if (widget.video) {
        _get_data.add(widget.data[i]);
      }
    }
  }

  void setDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Center(
                child:  GetTextField(
                  text: 'Description:',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: widget.video
                ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoItems(
                        data: _get_data,
                        ceo: true,
                      ),
                    ),
                  )
                : setDialog,
              icon: Image.network(
                'https://emin-teov.github.io/api/logo/photo_logo-${widget.employer_id}.png',
                width: (size / 4),
                height: (size / 4),
              ),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GetTextLabel(head: 'Job title', value: widget.tittle),
                GetTextLabel(head: 'Company', value: widget.employer),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
