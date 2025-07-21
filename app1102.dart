import 'package:flutter/material.dart';

void main() => runApp(const App1102());

class App1102 extends StatelessWidget {
  const App1102({super.key}); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView...')),
      body: GridView.extent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: const EdgeInsets.all(10),
        children: _gridChildren(),
      ),
    );
  }

  List<Widget> _gridChildren() {
    return List<Widget>.generate(10, (i) {
      // ให้แสดง 10 ภาพ
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://picsum.photos/200?ramdom=$i',
          fit: BoxFit.cover,
        ),
      );
    });
  }
}
