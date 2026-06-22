import 'package:flutter/material.dart';
import 'package:todo_app/helper/database_helper.dart';
import 'package:todo_app/model/todo_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  List<TodoModel> todo = [];
  bool isUpdate = false;
  int? updateID;

  @override
  void initState() {
    getTodo();
    super.initState();
  }

  void editTodo(TodoModel todo) {
    title.text = todo.title;
    description.text = todo.description;
    updateID = todo.id;
    updateID;
    setState(() {
      isUpdate = true;
    });
  }

  Future<void> saveOrUpdate() async {
    var valueTodo = TodoModel(
      title: title.text.trim(),
      description: description.text.trim(),
      id: updateID,
    );

    if (isUpdate) {
      await DatabaseHelper.updateTodo(valueTodo);
    } else {
      await DatabaseHelper.insertToDo(valueTodo);
    }

    description.clear();
    title.clear();
    setState(() {
      isUpdate = false;
      updateID = null;
    });
    getTodo();
  }

  Future<void> getTodo() async {
    final data = await DatabaseHelper.getTodo();
    setState(() {
      todo = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100.withAlpha(75),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          spacing: 12,
          children: [
            TextFormField(
              controller: title,

              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: .circular(12)),
                hintText: 'title',
              ),
            ),
            TextFormField(
              maxLines: 4,
              controller: description,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: .circular(12)),
                hintText: 'descreption',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                saveOrUpdate();
              },
              child: Text(isUpdate ? 'Update' : 'Save'),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: todo.length,
              itemBuilder: (BuildContext context, int index) {
                var todos = todo[index];
                return Card(
                  child: ListTile(
                    leading: Text(todos.id.toString()),
                    title: Text(todos.title),
                    subtitle: Text(todos.description),
                    trailing: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            editTodo(todos);
                            // print('todo updated ');
                          },
                          child: Icon(Icons.edit),
                        ),

                        InkWell(
                          onTap: () async {
                            DatabaseHelper.deltTode(todos.id!);
                            getTodo();
                          },
                          child: Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
