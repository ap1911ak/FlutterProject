import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() => runApp(App1306());

class App1306 extends StatelessWidget {
  const App1306({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global State Badges Demo', // Added a title
      theme: ThemeData(primarySwatch: Colors.green), // Added a basic theme
      home: MyHomePage(title: 'Global State Badges Demo'), // Fixed: Provided the required 'title' argument
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.green.shade100,
          padding: const EdgeInsets.all(30),
          child: Provider(
            create: (context) => ShowDialogText(),
            builder: (_, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  TextFieldWidget(),
                  ButtonWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.blue.shade100,
      child: TextField(
        controller: context.read<ShowDialogText>().textController,
        decoration: const InputDecoration(
          hintText: "enter text",
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.yellow.shade200,
      child: ElevatedButton(
        child: const Text('TAB'),
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Provider.of<ShowDialogText>(context, listen: false).textController.text,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShowDialogText {
  TextEditingController textController = TextEditingController();
}
