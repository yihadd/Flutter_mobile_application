import 'package:flutter/material.dart';
import 'sound_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? savedName = prefs.getString('user_name');
  
  runApp(BirthdayCardApp(initialName: savedName));
}

class BirthdayCardApp extends StatelessWidget {
  final String? initialName;
  
  const BirthdayCardApp({Key? key, this.initialName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: initialName == null 
          ? const Scaffold(
              backgroundColor: Color(0xFF59BFC6),
              body: BirthdayCard(),
            )
          : SecondPage(userName: initialName!),
      routes: {
        '/second': (context) => const SecondPage(),
        '/sound-list': (context) => const SoundListPage(),
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

  Future<void> _saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

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
                  labelText: 'Please enter your name',
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
                onPressed: () async {
                  if (_name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your name first')),
                    );
                    return;
                  }
                  await _saveName(_name);
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(userName: _name),
                    ),
                  );
                },
                child: const Text('Go to Happy Eid Page'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildConfetti() { // Group multiple widgets to create complex or dynamic UIs
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
  final String userName;
  
  const SecondPage({Key? key, this.userName = ''}) : super(key: key);

  Future<void> _resetName(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BirthdayCard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = userName.isNotEmpty 
        ? userName 
        : (ModalRoute.of(context)?.settings.arguments as String? ?? '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Eid'),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Happy Eid $displayName!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sound-list');
            },
            child: const Text('Go to Sound List'),
          ),
          ElevatedButton(
            onPressed: () => _resetName(context),
            child: const Text('Reset Name'),
          ),
        ],
      ),
    );
  }
}
