class API {
  static const baseUrl = "https://lib.techtonic.asia";
  static const apiKey = "3fcabab088e24401858a47fd66fe7a0d";
  static const apiKey1 = "524a2c554db84a6092b5cf2ccdc2aced";

  static String newsApi(
          {required String country, String? source, int page = 1}) =>
      "https://newsapi.org/v2/top-headlines?country=$country&$page&sources=${source ?? ''}&apiKey=$apiKey1";

  static String searchApi({required String query, int page = 1}) =>
      "https://newsapi.org/v2/everything?q=$query&$page&apiKey=$apiKey1";
}
