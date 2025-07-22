import 'package:flutter/material.dart';
import 'dart:convert'; // For jsonDecode
import 'package:http/http.dart' as http; // For API calls
import 'dart:math'; // For Random number generation

// --- api.dart content combined ---
Future<Map<String, dynamic>> apiGetTodo(int id) async {
  var response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/todos/$id'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to load todo for ID: $id');
  }
}
// --- End of api.dart content ---


void main() => runApp(const App1402()); // Added const

class App1402 extends StatelessWidget {
  const App1402({Key? key}) : super(key: key); // Added const constructor
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random REST API Example', // Updated title
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // Added const
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key); // Added const constructor
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> _todoFuture;
  String _text = '';
  bool _apiCalling = false; // Initialized to false as no API call on start
  int _todoId = 1; // Store the current todo ID

  @override
  void initState() {
    super.initState();
    // No initial API call on initState by default as per the image's logic,
    // but you could add _fetchRandomTodo() here if you want it on app start.
  }

  void _fetchRandomTodo() {
    setState(() {
      _apiCalling = true; // Show loading indicator
      _text = ''; // Clear previous text
    });

    // Generate a random ID between 1 and 20 (inclusive)
    _todoId = 1 + Random().nextInt(20);

    _todoFuture = apiGetTodo(_todoId);
    _todoFuture.then((value) {
      setState(() {
        _text = 'id: ${_todoId}\n'; // Use _todoId for display
        _text += 'title: ${value['title']}\n';
        _text += 'completed: ${value['completed']}';
        _apiCalling = false;
      });
    }).catchError((error) {
      setState(() {
        _text = 'Error fetching todo: $error';
        _apiCalling = false;
      });
      print('Error: $error'); // For debugging
    });
  }

  // Extracted the button into a method for better structure
  Widget _buildRandomTodoButton() {
    return TextButton(
      onPressed: _apiCalling ? null : _fetchRandomTodo, // Disable button while loading
      child: const Text(
        'Random Todo',
        style: TextStyle(fontSize: 18.0), // Consistent text style
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('REST API')),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column( // Use Column to arrange widgets vertically
          children: [
            // Display loading indicator or text
            _apiCalling
                ? const CircularProgressIndicator()
                : Text(
                    _text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18.0),
                  ),
            const SizedBox(height: 30), // Spacing
            _buildRandomTodoButton(), // The button
          ],
        ),
      ),
    );
  }
}
