class AuthController {
  static String? apiToken;

  static bool get isLoggedInUser => apiToken != null;

  static void setApiToken(String newToken) {
    apiToken = newToken;
  }

  static void clearToken() {
    apiToken = null;
  }
}
