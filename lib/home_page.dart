import 'package:flutter/material.dart';

import 'screens/done_screen.dart';
import 'screens/task_screen.dart';
import 'shared/models/todo_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _toDoItemList = <ToDoItem>[];
  final _doneItemList = <ToDoItem>[];

  final _pageViewController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  var _selectedIndex = 0;

  void onAddItem(String itemTitle) {
    setState(() {
      _toDoItemList.add(
        ToDoItem(
          title: itemTitle,
        ),
      );
    });
  }

  void onResetItem(ToDoItem item) {
    setState(() {
      _doneItemList.remove(item);

      _toDoItemList.add(
        ToDoItem(
          title: item.title,
        ),
      );
    });
  }

  void onRemoveToDoItem(ToDoItem item) {
    setState(() {
      _toDoItemList.remove(item);
    });
  }

  void onRemoveDoneItem(ToDoItem item) {
    setState(() {
      _doneItemList.remove(item);
    });
  }

  void onCompleteItem(ToDoItem item) {
    setState(() {
      _toDoItemList.remove(item);

      _doneItemList.add(
        ToDoItem(
          title: item.title,
          isDone: true,
        ),
      );
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          TaskScreen(
            itemList: _toDoItemList,
            onAddItem: onAddItem,
            onCompleteItem: onCompleteItem,
            onRemoveItem: onRemoveToDoItem,
          ),
          DoneScreen(
            itemList: _doneItemList,
            onRemoveItem: onRemoveDoneItem,
            onResetItem: onResetItem,
          ),
        ],
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);

          _pageViewController.animateToPage(
            _selectedIndex,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: 'Pendentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Concluídas',
          ),
        ],
      ),
    );
  }
}
