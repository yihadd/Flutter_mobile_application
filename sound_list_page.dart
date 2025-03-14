import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundListPage extends StatefulWidget {
  const SoundListPage({Key? key}) : super(key: key);

  @override
  State<SoundListPage> createState() => _SoundListPageState();
}

class _SoundListPageState extends State<SoundListPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int? playingIndex;

  final List<Map<String, dynamic>> soundItems = [
    {'icon': Icons.music_note, 'text': 'Happy Eid Song', 'sound': 'eid_song.mp3'},
    {'icon': Icons.celebration, 'text': 'Celebration', 'sound': 'celebration.mp3'},
    {'icon': Icons.mosque, 'text': 'Takbir', 'sound': 'takbir.mp3'},
    {'icon': Icons.music_note, 'text': 'Arabic Music', 'sound': 'arabic.mp3'},
    {'icon': Icons.nature, 'text': 'Nature Sounds', 'sound': 'nature.mp3'},
    {'icon': Icons.waves, 'text': 'Ocean Waves', 'sound': 'waves.mp3'},
    {'icon': Icons.pets, 'text': 'Animal Sounds', 'sound': 'animals.mp3'},
    {'icon': Icons.child_care, 'text': 'Children Laughing', 'sound': 'children.mp3'},
    {'icon': Icons.music_note, 'text': 'Traditional Music', 'sound': 'traditional.mp3'},
    {'icon': Icons.celebration, 'text': 'Party Sounds', 'sound': 'party.mp3'},
    {'icon': Icons.nature_people, 'text': 'Birds Chirping', 'sound': 'birds.mp3'},
    {'icon': Icons.water, 'text': 'Waterfall', 'sound': 'waterfall.mp3'},
    {'icon': Icons.music_note, 'text': 'Piano Melody', 'sound': 'piano.mp3'},
    {'icon': Icons.forest, 'text': 'Forest Ambience', 'sound': 'forest.mp3'},
    {'icon': Icons.celebration, 'text': 'Fireworks', 'sound': 'fireworks.mp3'},
  ];

  Future<void> playSound(int index) async {
    if (playingIndex == index) {
      await audioPlayer.stop();
      setState(() => playingIndex = null);
    } else {
      final String soundPath = soundItems[index]['sound'];
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(soundPath));
      setState(() => playingIndex = index);
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound List'),
      ),
      body: ListView.builder(
        itemCount: soundItems.length,
        itemBuilder: (context, index) {
          final item = soundItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Icon(item['icon'], color: Colors.blue),
              title: Text(item['text']),
              trailing: IconButton(
                icon: Icon(
                  playingIndex == index ? Icons.stop : Icons.play_arrow,
                  color: Colors.blue,
                ),
                onPressed: () => playSound(index),
              ),
            ),
          );
        },
      ),
    );
  }
} 