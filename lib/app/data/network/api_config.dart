class ApiConfig {

  static late ApiConfig instance;

  ApiConfig._(this.baseUrl);

  final String baseUrl;

  static initialize({required String baseUrl}) {
     instance = ApiConfig._(baseUrl);
  }

}