import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  final List<String> _recentIds = ['101', '102'];

  @override
  List<String> fetchRecentSongIds() => List.unmodifiable(_recentIds);

  @override
  void addSongId(String id) {
    // remove duplicates then insert at the front (most recent first)
    _recentIds.remove(id);
    _recentIds.insert(0, id);
  }
}