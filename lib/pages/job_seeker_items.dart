import 'package:flutter/material.dart';

import 'package:video_list/models/job_seeker_model.dart';
import 'package:video_list/pages/job_seeker_item.dart';

class JobSeekerItems extends StatefulWidget {
  final List<JobSeekerModel> items;

  const JobSeekerItems({
    super.key,
    required this.items
  });

  @override
  State<JobSeekerItems> createState() => _JobSeekerItemsState();
}

class _JobSeekerItemsState extends State<JobSeekerItems> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Expanded(
        child: GridView.builder(
          itemCount: widget.items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: ((size.width / 3) / ((size.height - kToolbarHeight - 24) / 2)),
            mainAxisSpacing: 124.0,
            crossAxisSpacing: 0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return JobSeekerItem(
              id: widget.items[index].id,
              data: widget.items.sublist(index, widget.items.length),
            );
          }
        ),
      ),
    );
  }
}
