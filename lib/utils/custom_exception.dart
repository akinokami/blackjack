class CustomException implements Exception {
  dynamic message;

  CustomException([this.message]);
  @override
  String toString() {
    if (message == null) return "Something went wrong !";
    return message;
  }
}

class NoInternetException implements Exception {
  @override
  String toString() {
    return 'No internet connection !';
  }
}