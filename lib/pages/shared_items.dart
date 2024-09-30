import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/pages/shared_item.dart';

class SharedItems extends StatefulWidget {
  final int item_index;
  final List items;

  const SharedItems({
    super.key,
    required this.item_index,
    required this.items,
  });

  @override
  State<SharedItems> createState() => _SharedItemsState();
}

class _SharedItemsState extends State<SharedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: OrientationBuilder(builder: (context, orientation) {
          return GridView.builder(
            itemCount: widget.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SharedItem(
                id: widget.items[index].id,
                index: widget.item_index,
                user: widget.item_index == 0
                    ? '${widget.items[index].name} ${widget.items[index].surname}'
                    : widget.item_index == 1
                        ? widget.items[index].ceo
                        : widget.items[index].username,
                title: AppLocalizations.of(context).categories(widget.items[index].employment),
                data: widget.items.sublist(index, widget.items.length),
              );
            },
          );
        }),
      ),
    );
  }
}
