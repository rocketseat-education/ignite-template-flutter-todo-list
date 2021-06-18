import 'package:flutter/material.dart';

import '../shared/models/todo_item.dart';
import 'components/todo_item_list_tile.dart';

class DoneScreen extends StatefulWidget {
  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  final _toDoItemList = <ToDoItem>[];
  final _doneItemList = <ToDoItem>[];

  @override
  Widget build(BuildContext context) {
    // appBar

    return Container(
      height: 500,
      padding: const EdgeInsets.only(bottom: 32),
      child: ListView.builder(
        itemCount: _toDoItemList.length,
        itemBuilder: (context, index) {
          final item = _toDoItemList[index];
          return ToDoItemListTile(
            item: item,
            onRemoveItem: () {
              setState(() {
                _toDoItemList.remove(item);
              });
            },
            onCompleteItem: () {
              setState(() {
                _toDoItemList.remove(item);
                _doneItemList.add(
                  ToDoItem(
                    title: item.title,
                    isDone: true,
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}
