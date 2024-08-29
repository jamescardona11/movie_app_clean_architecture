abstract class UrlRoutes {
  static get _baseMovieApiURL => 'https://api.themoviedb.org/3';
  static get posterURL => 'https://image.tmdb.org/t/p/w500';

  static get popularMoviesURL => '$_baseMovieApiURL/movie/popular';
  static get nowPlayingMoviesURL => '$_baseMovieApiURL/movie/now_playing';
  static get genresURL => '$_baseMovieApiURL/genre/movie/list';
}
