class NetworkResponse {
  final bool isSuccess;
  final dynamic responseData;
  final String errorMessage;
  final int statusCode;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong.',
  });
}