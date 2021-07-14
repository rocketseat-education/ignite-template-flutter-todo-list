import 'package:flutter/material.dart';

import '../../shared/models/todo_item.dart';

class ToDoItemListTile extends StatelessWidget {
  ToDoItemListTile({
    Key? key,
    required this.item,
    required this.onRemoveItem,
    required this.onChangeItem,
  }) : super(key: key);

  final ToDoItem item;
  final VoidCallback onRemoveItem;
  final VoidCallback onChangeItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => onRemoveItem(),
      background: Container(
        color: Colors.red,
        alignment: Alignment(-0.9, 0.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          item.title,
          style: TextStyle(
            fontStyle: item.isDone ? FontStyle.italic : null,
            decoration: item.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        value: item.isDone,
        onChanged: (_) => onChangeItem(),
      ),
    );
  }
}
