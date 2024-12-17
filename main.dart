import 'package:flutter/material.dart';

void main() {
  runApp(const BirthdayCardApp());
}

class BirthdayCardApp extends StatelessWidget {
  const BirthdayCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF59BFC6), // Teal Background
        body: const BirthdayCard(),
      ),
    );
  }
}

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Confetti Decorations
        ..._buildConfetti(),

        // Centered Birthday Card Content
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Happy Birthday Text
              const Text(
                'SALAM BRO',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              // Cupcake with Candle
              _buildCupcake(),
              const SizedBox(height: 10),
              // Bottom Message
              const Text(
                'Happy Hari Raya!',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              const Text(
                '-from Johan',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Confetti Dots
  List<Widget> _buildConfetti() {
    final confettiColors = [Colors.yellow, Colors.red, Colors.blue, Colors.pink];
    final positions = [
      const Offset(50, 50),
      const Offset(300, 80),
      const Offset(200, 500),
      const Offset(150, 350),
      const Offset(300, 700),
    ];

    return List.generate(positions.length, (index) {
      return Positioned(
        top: positions[index].dy,
        left: positions[index].dx,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: confettiColors[index % confettiColors.length],
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }

  // Cupcake Widget
  Widget _buildCupcake() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Cupcake Base
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.greenAccent, width: 2),
            ),
          ),
          // Whipped Cream (Placeholder with White Container)
          Positioned(
            top: 0,
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  )
                ],
              ),
            ),
          ),
          // Candle
          Positioned(
            top: 10,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 60,
                  color: Colors.yellow,
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
