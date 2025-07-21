import 'package:flutter/material.dart';
import 'dart:math'; // สำหรับ Random

void main() => runApp(const App1104()); // เพิ่ม const

class App1104 extends StatelessWidget {
  const App1104({super.key}); // เพิ่ม super.key

  @override
  Widget build(BuildContext context) {
    return  MaterialApp( // เพิ่ม const
      home: HomePage(), // เพิ่ม const
    );
  }
}

class HomePage extends StatelessWidget {
  // สร้าง instance ของ Random ใน constructor หรือใช้ static final เพื่อไม่ให้สร้างใหม่ทุกครั้ง
  // ในที่นี้จะสร้างใน buildGridTile แทน เพื่อให้ rnd.nextInt(200) ทำงานได้
  // หรืออีกทางเลือกคือใช้ StatefullWidget ถ้าต้องการให้ค่า Random คงที่
  final Random _rnd = Random(); // สร้าง Random instance ครั้งเดียว

  HomePage({super.key}); // เพิ่ม super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView.build')), // เพิ่ม const
      body: GridView.builder(
        itemCount: 7, // จาก image_64da7a.png
        padding: const EdgeInsets.all(10), // เพิ่ม const
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // เปลี่ยนจาก SliverGridDelegateWithMaxCrossAxisExtent
          crossAxisCount: 2, // กำหนดจำนวนคอลัมน์คงที่ (ตัวอย่าง, คุณสามารถปรับได้)
          childAspectRatio: 3 / 4, // จาก image_64da5c.png
          crossAxisSpacing: 5, // จาก image_64da5c.png
          mainAxisSpacing: 5, // จาก image_64da5c.png
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15), // จาก image_64da5c.png
            child: _buildGridTile(context, index + 1), // ใช้ _buildGridTile
          );
        },
      ),
    );
  }

  // ทำให้เป็น private method โดยใส่ underscore หน้าชื่อ
  Widget _buildGridTile(BuildContext ctx, int index) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(
          'สินค้า \$index',
          textScaler: const TextScaler.linear(1.3), // ใช้ TextScaler.linear แทน textScaleFactor
        ),
        subtitle: Text('\$\$${50 + _rnd.nextInt(200)}'), // ใช้ _rnd ที่สร้างไว้
        trailing: InkWell(
          child: const Icon( // เพิ่ม const
            Icons.zoom_in,
            size: 32,
            color: Colors.white,
          ),
          onTap: () {
            _alert(ctx, 'เปิดดูสินค้า $index'); // ใช้ _alert
          },
        ),
      ),
      child: Image.network(
        'https://picsum.photos/200?random=$index', // ใช้ $index เพื่อให้ภาพไม่ซ้ำกัน
        fit: BoxFit.cover,
      ),
    );
  }

  // ทำให้เป็น private method โดยใส่ underscore หน้าชื่อ
  void _alert(BuildContext ctx, String msg) {
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        content: Text(
          msg,
          textScaler: const TextScaler.linear(1.3), // ใช้ TextScaler.linear แทน textScaleFactor
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK', textScaler: TextScaler.linear(1.3)), // เพิ่ม const และ TextScaler.linear
          ),
        ],
      ),
    );
  }
}
