import 'package:flutter/widgets.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../data/repositories/user_history/user_history_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  // injected dependencies
  final SongRepository _songRepository;
  final UserHistoryRepository _userHistoryRepository;
  final PlayerState _playerState;

  // internal state
  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  HomeViewModel({
    required SongRepository songRepository,
    required UserHistoryRepository userHistoryRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _userHistoryRepository = userHistoryRepository,
        _playerState = playerState {
    // Listen to PlayerState so UI rebuilds when the current song changes
    _playerState.addListener(_onPlayerStateChanged);
  }


  void init() {
    _loadSongs();
    notifyListeners();
  }

  
  List<Song> get recentSongs => _recentSongs;

  List<Song> get recommendedSongs => _recommendedSongs;

  Song? get currentSong => _playerState.currentSong;

  bool isPlaying(Song song) => _playerState.currentSong == song;

  
  void play(Song song) {
    // Record the play in history, then start playback
    _userHistoryRepository.addSongId(song.id);
    _playerState.start(song);

    // Reload so the recent list updates immediately
    _loadSongs();
    notifyListeners();
  }

  void stop() {
    _playerState.stop();
  }

  void _loadSongs() {
    final allSongs = _songRepository.fetchSongs();
    final recentIds = _userHistoryRepository.fetchRecentSongIds();

    // Recent songs: convert IDs → full Song objects (preserve order)
    _recentSongs = recentIds
        .map((id) => _songRepository.fetchSongById(id))
        .whereType<Song>() // drop nulls (song may have been deleted)
        .toList();

    // Recommended: songs the user has NOT recently played
    final recentIdSet = recentIds.toSet();
    _recommendedSongs =
        allSongs.where((s) => !recentIdSet.contains(s.id)).toList();
  }

  void _onPlayerStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}