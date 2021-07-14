import 'package:flutter/material.dart';

import '../shared/models/todo_item.dart';
import 'components/todo_item_list_tile.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({
    Key? key,
    required this.itemList,
    required this.onResetItem,
    required this.onRemoveItem,
  }) : super(key: key);

  final List<ToDoItem> itemList;
  final ValueChanged<ToDoItem> onResetItem;
  final ValueChanged<ToDoItem> onRemoveItem;

  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24),
        Text(
          'Concluídas',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: widget.itemList.length,
            itemBuilder: (context, index) {
              final item = widget.itemList[index];

              return ToDoItemListTile(
                item: item,
                onRemoveItem: () => widget.onRemoveItem(item),
                onChangeItem: () => widget.onResetItem(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
