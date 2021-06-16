import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final _toDoItemTitleEditingController = TextEditingController();
  final _toDoItemList = <ToDoItem>[];
  final _doneItemList = <ToDoItem>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
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
      ),
    );
  }
}

class ToDoItemListTile extends StatelessWidget {
  ToDoItemListTile({
    Key? key,
    required this.item,
    required this.onRemoveItem,
    required this.onCompleteItem,
  }) : super(key: key);

  final ToDoItem item;
  final VoidCallback onRemoveItem;
  final VoidCallback onCompleteItem;

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
        onChanged: (_) => onCompleteItem(),
      ),
    );
  }
}

class ToDoItem {
  ToDoItem({
    required this.title,
    this.isDone = false,
  });

  final String title;
  final bool isDone;
}
