abstract class UserHistoryRepository {
  List<String> fetchRecentSongIds();

  void addSongId(String id);
}