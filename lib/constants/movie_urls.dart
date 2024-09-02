class MovieUrls {
  static String genreListUrl(String base) => '$base/movie/list';
  static String movieShowingListUrl(String base) => '$base/now_playing';
  static String moviePopularListUrl(String base) => '$base/popular';
  static String movieDetailUrl(String base, String id) => '$base/$id';
  static String movieCastUrl(String base, String id) => '$base/$id/credits';

  static String fallbackCastImage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";

  static String fallbackMovieBackDropImage = "https://pbs.twimg.com/media/Dtqu4oFXQAAuoSQ.jpg";
}
