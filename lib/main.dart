// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = [];

  final TextEditingController _textEditingController = TextEditingController();
  int _editingIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List\nMade by Sanan Baig',
          style: TextStyle(
            color: Colors.white, // Set the text color of the app bar title
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.black, // Background color for the container
                  child: ListTile(
                    title: Text(
                      todos[index],
                      style: const TextStyle(
                        color: Colors.white, // Text color for the todo
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _startEditing(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteTodo(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10.0, bottom: 30.0),
                    child: TextField(
                      controller: _textEditingController,
                      onSubmitted: (value) {
                        if (_editingIndex == -1) {
                          _addTodo(value);
                        } else {
                          _editTodo();
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Add a todo...',
                        hintStyle: TextStyle(
                          color: Colors.grey, // Set hint text color
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black, // Set text color
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_editingIndex == -1) {
                      _addTodo(_textEditingController.text);
                    } else {
                      _editTodo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black, // Set button background color
                  ),
                  child: Text(
                    _editingIndex == -1 ? 'Add' : 'Save',
                    style: const TextStyle(
                      color: Colors.white, // Set button text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addTodo(String todo) {
    setState(() {
      todos.add(todo);
      _textEditingController.clear();
    });
  }

  void _startEditing(int index) {
    setState(() {
      _textEditingController.text = todos[index];
      _editingIndex = index;
    });
  }

  void _editTodo() {
    setState(() {
      todos[_editingIndex] = _textEditingController.text;
      _textEditingController.clear();
      _editingIndex = -1;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }
}
