import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final settingsState = context.read<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Center(child: Text("Home", style: AppTextStyles.heading)),
          const SizedBox(height: 24),

          // recent songs played
          _SectionHeader(label: "Your recent songs"),
          if (vm.recentSongs.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("No songs played yet."),
            )
          else
            ...vm.recentSongs.map(
              (song) => _SongTile(
                song: song,
                isPlaying: vm.isPlaying(song),
                onTap: () => vm.play(song),
                onStop: vm.stop,
              ),
            ),

          const SizedBox(height: 16),

          // recommended songs
          _SectionHeader(label: "You might also like"),
          if (vm.recommendedSongs.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Nothing to recommend yet."),
            )
          else
            ...vm.recommendedSongs.map(
              (song) => _SongTile(
                song: song,
                isPlaying: vm.isPlaying(song),
                onTap: () => vm.play(song),
                onStop: vm.stop,
              ),
            ),
        ],
      ),
    );
  }
}


class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _SongTile extends StatelessWidget {
  const _SongTile({
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
                OutlinedButton(
                  onPressed: onStop,
                  child: const Text("STOP"),
                ),
              ],
            )
          : null,
    );
  }
}