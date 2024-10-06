import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState(); //extends State<TaskListScreen> {
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController(); //TextEditingController for the TextField

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: _taskController.text));
        _taskController.clear(); //adds task to the list index and clears the text field
      });
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted; //toggles the task list
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index); //deletes the task list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/note.jpg',
              fit: BoxFit.cover,
            ),
          ),
          
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          labelText: 'Enter task name',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addTask,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile( //dynamicly creates the list of tasks from _tasks list
                      leading: Checkbox(
                        value: _tasks[index].isCompleted,
                        onChanged: (value) {
                          _toggleTaskCompletion(index);
                        },
                      ),
                        title: AnimatedOpacity(
                        opacity: _tasks[index].isCompleted ? 0.5 : 1.0,
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          _tasks[index].name, //displays task name, if completed then line through
                          style: TextStyle(
                            decoration: _tasks[index].isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}