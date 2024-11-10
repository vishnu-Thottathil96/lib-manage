class ApiConfig {
  // Static base URL for API
  static const String baseUrl = 'https://assessment.eltglobal.in/';

  // Endpoints
  static const String fetchAuthors = 'api/authors';
  static const String fetchBooks = 'api/books';
  static const String register = 'api/auth/register';
  static const String login = 'api/auth/login';

  // If you have more static configurations
  static const String appVersion = '1.0.0';
  static const bool enableLogging = true; // Example of a feature flag
}
