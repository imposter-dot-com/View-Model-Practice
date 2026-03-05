import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/library_view_model.dart';
import 'song_tiles.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the view model -> rebuild whenever notifyListeners() fires
    final vm = context.watch<LibraryViewModel>();

    // 2- Read the globbal settings state
    AppSettingsState settingsState = context.read<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: vm.songs.length,
              itemBuilder: (context, index) {
                final song = vm.songs[index];
                return SongTile(
                  song: song,
                  isPlaying: vm.isPlaying(song),
                  onTap: () => vm.play(song),
                  onStop: vm.stop,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


