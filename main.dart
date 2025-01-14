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
        backgroundColor: const Color(0xFF59BFC6), // Teal Background
        body: const BirthdayCard(),
      ),
      routes: {
        '/second': (context) => const SecondPage(),
      },
    );
  }
}

class BirthdayCard extends StatefulWidget {
  const BirthdayCard({Key? key}) : super(key: key);

  @override
  _BirthdayCardState createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard> {
  final TextEditingController _nameController = TextEditingController();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ..._buildConfetti(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SALAM BRO',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              _buildCupcake(),
              const SizedBox(height: 10),
              Text(
                _name.isEmpty ? 'Happy Hari Raya!' : 'Happy Hari Raya, $_name!',
                style: const TextStyle(fontSize: 22, color: Colors.black),
              ),
              const Text(
                '-from Johan',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: const Text('Go to Next Page'),
              ),
            ],
          ),
        ),
      ],
    );
  }

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

  Widget _buildCupcake() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.greenAccent, width: 2),
            ),
          ),
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
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
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

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.home, 'name': 'Home'},
      {'icon': Icons.person, 'name': 'Profile'},
      {'icon': Icons.settings, 'name': 'Settings'},
      {'icon': Icons.notifications, 'name': 'Notifications'},
      {'icon': Icons.camera_alt, 'name': 'Camera'},
      {'icon': Icons.message, 'name': 'Messages'},
      {'icon': Icons.shopping_cart, 'name': 'Cart'},
      {'icon': Icons.favorite, 'name': 'Favorites'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          Image.network(
            'https://uploads.dailydot.com/2024/09/roblox-face-meme.jpg?q=65&auto=format&w=1200&ar=2:1&fit=crop',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Failed to load image'));
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(item['icon'], color: Colors.blue),
                  title: Text(item['name']),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item['name']} clicked')),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to First Page'),
            ),
          ),
        ],
      ),
    );
  }
}
