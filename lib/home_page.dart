import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _toDoController = TextEditingController();
  final _toDo = [];
  bool _isSelected = false;

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
                        controller: _toDoController,
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
                        if (_toDoController.text.isEmpty) return;
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _toDo.add(_toDoController.text);
                          });
                          _toDoController.clear();
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
                  itemCount: _toDo.length,
                  itemBuilder: (context, index) {
                    final item = _toDo[index];
                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        setState(() {
                          _toDo.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment(-0.9, 0.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          item,
                          style: TextStyle(
                            fontStyle: _isSelected ? FontStyle.italic : null,
                            decoration: _isSelected 
                                ? TextDecoration.lineThrough 
                                : null,
                          ),
                        ),
                        value: _isSelected,
                        onChanged: (value) {
                          setState(() {
                            _isSelected = value!;
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
