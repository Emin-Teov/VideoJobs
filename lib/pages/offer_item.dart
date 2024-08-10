import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/get_text_label.dart';
import 'package:video_list/pages/video_items.dart';

class OfferItem extends StatefulWidget {
  final int id;
  final String tittle;
  final int employer_id;
  final String employer;
  final String url;
  final String description;
  final List data;

  const OfferItem({
    super.key,
    required this.id,
    required this.tittle,
    required this.employer_id,
    required this.employer,
    required this.url,
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
      if (!widget.data[i].url.isEmpty) {
        _get_data.add(widget.data[i]);
      }
    }
  }

  void showDescription() {
    showDialog(
      context: context,
      builder: (context) {
        var size = MediaQuery.of(context).size;
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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: size.width,
                  height: size.height / 2,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
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
              onPressed: widget.url.isEmpty
                  ? showDescription
                  : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoItems(
                            data: _get_data,
                            ceo: true,
                          ),
                        ),
                      ),
              icon: Image.network(
                'https://emin-teov.github.io/api/logo/photo-logo-${widget.employer_id}.png',
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
