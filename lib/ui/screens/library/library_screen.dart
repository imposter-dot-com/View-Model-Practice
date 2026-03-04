import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../ui/states/player_state.dart';
import 'view_model/library_view_model.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late final LibraryViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    // Read the globally-provided dependencies (from main_dev.dart providers)
    final songRepository = context.read<SongRepository>();
    final playerState = context.read<PlayerState>();

    // Create the ViewModel and immediately fetch data
    _viewModel = LibraryViewModel(
      songRepository: songRepository,
      playerState: playerState,
    );
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provide the ViewModel to the widget subtree
    return ChangeNotifierProvider<LibraryViewModel>.value(
      value: _viewModel,
      child: const LibraryContent(),
    );
  }
}