import 'package:flutter/material.dart';

import '../shared/models/todo_item.dart';
import 'components/todo_item_list_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    Key? key,
    required this.itemList,
    required this.onAddItem,
    required this.onCompleteItem,
    required this.onRemoveItem,
  }) : super(key: key);

  final List<ToDoItem> itemList;
  final ValueChanged<ToDoItem> onCompleteItem;
  final ValueChanged<String> onAddItem;
  final ValueChanged<ToDoItem> onRemoveItem;

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _toDoItemTitleEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          Text(
            'Pendentes',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _toDoItemTitleEditingController,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 24,
                  ),
                  onPressed: () {
                    if (_toDoItemTitleEditingController.text.isNotEmpty) {
                      widget.onAddItem(_toDoItemTitleEditingController.text);

                      _toDoItemTitleEditingController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: widget.itemList.length,
              itemBuilder: (context, index) {
                final item = widget.itemList[index];
                return ToDoItemListTile(
                  item: item,
                  onRemoveItem: () => widget.onRemoveItem(item),
                  onChangeItem: () => widget.onCompleteItem(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
