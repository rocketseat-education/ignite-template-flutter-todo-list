import 'package:flutter/material.dart';

import '../shared/models/todo_item.dart';
import 'components/todo_item_list_tile.dart';

class TaskScreen extends StatefulWidget {

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final _formKey = GlobalKey<FormState>();
  final _toDoItemTitleEditingController = TextEditingController();
  final _toDoItemList = <ToDoItem>[];
  final _doneItemList = <ToDoItem>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
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
                        setState(() {
                          _toDoItemList.add(
                            ToDoItem(
                              title: _toDoItemTitleEditingController.text,
                            ),
                          );
                        });
                        _toDoItemTitleEditingController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
