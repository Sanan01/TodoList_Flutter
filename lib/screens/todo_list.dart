import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = [];
  final TextEditingController _textEditingController = TextEditingController();
  int _editingIndex = -1;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('todoListScaffold'),
      appBar: AppBar(
        title: const Text(
          'Todo List\nMade by Sanan Baig',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Call the logout function when the button is pressed
              await _logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              key: const Key('todoList'),
              itemCount: todos.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemBuilder: (context, index) {
                return TodoItem(
                  todo: todos[index],
                  onEdit: () {
                    _startEditing(index);
                  },
                  onDelete: () {
                    _deleteTodo(index);
                  },
                );
              },
            ),
          ),
          TodoInput(
            focusNode: _focusNode,
            controller: _textEditingController,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                _handleTodoAction(value);
              }
            },
            buttonText: _editingIndex == -1 ? 'Add' : 'Save',
            onPressed: () {
              if (_textEditingController.text.isNotEmpty) {
                _handleTodoAction(_textEditingController.text);
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleTodoAction(String todo) {
    setState(() {
      if (_editingIndex == -1) {
        todos.add(todo);
      } else {
        todos[_editingIndex] = todo;
        _editingIndex = -1;
      }
      _textEditingController.clear();
    });
  }

  void _startEditing(int index) {
    setState(() {
      _textEditingController.text = todos[index];
      _editingIndex = index;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  Future<void> _logout() async {
    try {
      // Sign out the user from Firebase Auth
      await FirebaseAuth.instance.signOut();
      // Optionally, you can navigate to the login screen or perform other tasks
      // after successfully logging out the user.
    } catch (e) {
      print("Error during logout: $e");
    }
  }
}

class TodoItem extends StatelessWidget {
  final String todo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoItem({
    required this.todo,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListTile(
        title: Text(
          todo,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class TodoInput extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final String buttonText;
  final VoidCallback onPressed;

  const TodoInput({
    required this.focusNode,
    required this.controller,
    required this.onSubmitted,
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10.0, bottom: 30.0),
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                onSubmitted: onSubmitted,
                decoration: const InputDecoration(
                  hintText: 'Add a todo...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
