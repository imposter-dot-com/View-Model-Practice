import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../data/repositories/user_history/user_history_repository.dart';
import '../../states/player_state.dart';
import 'view_model/home_view_model.dart';
import 'widgets/home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    // Read globally-provided dependencies
    final songRepository = context.read<SongRepository>();
    final userHistoryRepository = context.read<UserHistoryRepository>();
    final playerState = context.read<PlayerState>();

    // Create the ViewModel and fetch data
    _viewModel = HomeViewModel(
      songRepository: songRepository,
      userHistoryRepository: userHistoryRepository,
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
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: _viewModel,
      child: const HomeContent(),
    );
  }
}