import 'package:flutter/material.dart';
import '../../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: isPlaying
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "playing",
                  style: TextStyle(color: Colors.pinkAccent),
                ),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: onStop, child: const Text("STOP")),
              ],
            )
          : null,
    );
  }
}