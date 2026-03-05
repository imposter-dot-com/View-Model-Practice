import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/home_view_model.dart';
import '../../library/widgets/song_tiles.dart';

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
              (song) => SongTile(
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
              (song) => SongTile(
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

