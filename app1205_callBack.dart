// main.dart (combined from app1205/lib/main.dart and product_detail.dart)

import 'package:flutter/material.dart';
import 'dart:math'; // Required for Random class

void main() => runApp(const App1205());

class App1205 extends StatelessWidget {
  const App1205({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App', // Added a title for the app
      theme: ThemeData(primarySwatch: Colors.teal), // Added a basic theme
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/product_detail': (context) => const ProductDetail(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Random rnd = Random(); // Initialize Random inside build for StatelessWidget

    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: GridView.builder(
        itemCount: 6,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisExtent( // Added const here
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          // Generate a price randomly for each item
          int price = 50 + rnd.nextInt(200);
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: buildGridTile(context, index + 1, price), // index + 1 for product ID
          );
        },
      ),
    );
  }

  Widget buildGridTile(BuildContext ctx, int index, int price) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(
          'Item $index',
          textScaler: TextScaler.linear(1.3),
        ),
        subtitle: Text('\$\$${price.toStringAsFixed(0)}'), // Display price
        trailing: InkWell(
          child: const Icon(
            Icons.zoom_in,
            size: 32,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pushNamed(
              ctx,
              '/product_detail',
              arguments: {
                'id': index,
                'price': price,
              },
            );
          },
        ),
      ),
      child: Image.network(
        'https://picsum.photos/id/${(index * 100) % 1000}/250', // Use index for unique images
        fit: BoxFit.cover,
      ),
    );
  }
}

class SliverGridDelegateWithFixedCrossAxisExtent {
  const SliverGridDelegateWithFixedCrossAxisExtent();
}

// ProductDetail class (merged from app1205/lib/product_detail.dart)
class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract arguments from the route settings
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int id = args['id'];
    final int price = args['price']; // Extract price argument

    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://picsum.photos/id/${(id * 100) % 1000}/1000', // Use id for unique image
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            column2(id, price), // Pass id and price to column2
            const SizedBox(height: 25),
            column3(),
          ],
        ),
      ),
    );
  }

  Widget column2(int id, int price) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Item $id',
                textScaler: TextScaler.linear(1.5),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$\$${price.toStringAsFixed(0)}', // Display price here
                textScaler: TextScaler.linear(1.2),
              ),
            ],
          ),
          const Row( // This was missing the Row widget in the original snippet
            children: [
              Icon(
                Icons.add_shopping_cart,
                color: Colors.green,
                size: 36,
              ),
            ],
          ),
        ],
      );

  Widget column3() => Container(
        alignment: Alignment.centerLeft,
        child: const Text('Lorem ipsum dolor sit amet,...'),
      );
}
