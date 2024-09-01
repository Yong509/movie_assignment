class MovieUrls {
  static String genreListUrl(String base) => '$base/movie/list';
  static String movieShowingListUrl(String base) => '$base/now_playing';
  static String moviePopularListUrl(String base) => '$base/popular';
  static String movieDetailUrl(String base, String id) => '$base/$id';
  static String movieCastUrl(String base, String id) => '$base/$id/credits';
}
