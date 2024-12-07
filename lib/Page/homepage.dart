import 'package:flutter/material.dart';
import 'package:untitled1/Page/data/database.dart';
import 'package:untitled1/utilities/dialogbox.dart';
import 'package:untitled1/utilities/todotile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _myBox = Hive.box('MyBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST')== null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }

  final _controller = TextEditingController();



  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context) {
          return Dialogbox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
    );
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('TO DO'),
        centerTitle: true,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return Todotile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
