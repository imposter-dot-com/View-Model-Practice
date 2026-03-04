import 'package:provider/provider.dart';
import 'package:nested/nested.dart';

import 'main_common.dart';
import 'data/repositories/settings/app_settings_repository_mock.dart';
import 'data/repositories/songs/song_repository.dart';
import 'data/repositories/songs/song_repository_mock.dart';
import 'data/repositories/user_history/user_history_repository.dart';         
import 'data/repositories/user_history/user_history_repository_mock.dart';    
import 'ui/states/player_state.dart';
import 'ui/states/settings_state.dart';

List<SingleChildWidget> get devProviders {
  final appSettingsRepository = AppSettingsRepositoryMock();

  return [
    // 1 - Song repository
    Provider<SongRepository>(create: (_) => SongRepositoryMock()),

    // 2 - User history repository (NEW)
    Provider<UserHistoryRepository>(create: (_) => UserHistoryRepositoryMock()),

    // 3 - Player state
    ChangeNotifierProvider<PlayerState>(create: (_) => PlayerState()),

    // 4 - App settings state
    ChangeNotifierProvider<AppSettingsState>(
      create: (_) => AppSettingsState(repository: appSettingsRepository),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}