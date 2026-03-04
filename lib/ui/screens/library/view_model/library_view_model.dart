import 'package:flutter/widgets.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  // --- Injected dependencies ---
  final SongRepository _songRepository;
  final PlayerState _playerState;

  // --- Internal state ---
  List<Song> _songs = [];

  LibraryViewModel({
    required SongRepository songRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _playerState = playerState {
    // Listen to PlayerState so we rebuild UI when the playing song changes
    _playerState.addListener(_onPlayerStateChanged);
  }

  // called once when the ViewModel is created 
  void init() {
    _songs = _songRepository.fetchSongs();
    notifyListeners();
  }

  List<Song> get songs => _songs;

  Song? get currentSong => _playerState.currentSong;

  bool isPlaying(Song song) => _playerState.currentSong == song;

  bool get hasCurrentSong => _playerState.currentSong != null;

  void play(Song song) {
    _playerState.start(song);
  }

  void stop() {
    _playerState.stop();
  }

 void _onPlayerStateChanged() {
    // When player state changes, notify our own listeners (the UI)
    notifyListeners();
  }

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}