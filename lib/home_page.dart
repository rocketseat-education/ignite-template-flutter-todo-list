import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _toDoItemTitle = TextEditingController();
  final toDoItemList = [];
  bool isDone = false;

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
                        controller: _toDoItemTitle,
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.purple,
                        size: 36,
                      ),
                      onPressed: () {
                        if (_toDoItemTitle.text.isEmpty) return;
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            toDoItemList.add(_toDoItemTitle.text);
                          });
                          _toDoItemTitle.clear();
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
                  itemCount: toDoItemList.length,
                  itemBuilder: (context, index) {
                    final item = toDoItemList[index];
                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          debugPrint('done');
                        } else {
                          setState(() {
                            toDoItemList.removeAt(index);
                          });
                        }
                      },
                      background: Container(
                        color: Colors.green,
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(Icons.done, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment(0.9, 0.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          item,
                          style: TextStyle(
                            fontStyle: isDone ? FontStyle.italic : null,
                            decoration:
                                isDone ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        value: isDone,
                        onChanged: (value) {
                          setState(() {
                            isDone = value!;
                          });
                        },
                      ),
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
