import 'package:flutter/material.dart';
import 'package:video_list/pages/get_text_field.dart';
import 'package:video_list/pages/get_text_label.dart';

class OfferItem extends StatefulWidget {
  final int id;
  final String tittle;
  final String employer;
  final String description;

  const OfferItem({
    super.key,
    required this.id,
    required this.tittle,
    required this.employer,
    required this.description,
  });

  @override
  State<OfferItem> createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem> {
  void showDescription() {
    showDialog(
      context: context,
      builder: (context) {
        var size = MediaQuery.of(context).size.width;
        return AlertDialog(
          content: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close)
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                  width: size,
                  height: size,
                  child: Column(
                    children: <Widget>[
                      GetTextField(
                        text: 'Description:',
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
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
              onPressed: showDescription,
              icon: Image.network(
                'https://emin-teov.github.io/api/logo/photo-logo-${widget.id}.png',
                width: (size/4),
                height: (size/4),
              ),
            ),

          ],
        ),
        Expanded(
          child: SizedBox(
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GetTextLabel(head: 'Job title', value: widget.tittle),
                    GetTextLabel(head: 'Company', value: widget.employer),
                    // IconButton(onPressed: showDescription, icon: const Icon(Icons.drive_file_move)),
                  ],
                ),
          ),
        ),
      ],
    );
  }
}
