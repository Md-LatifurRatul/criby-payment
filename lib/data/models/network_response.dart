class NetworkResponse {
  final int? responseCode;
  final String? errorMessage;
  final dynamic responseData;
  final bool isSucess;

  NetworkResponse({
    required this.responseCode,
    required this.isSucess,
    this.errorMessage = 'Something went wrong!',
    this.responseData,
  });
}
