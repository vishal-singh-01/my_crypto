
class Status {
  final String timestamp;
  final int errorCode;
  final String errorMessage;

  Status({
    required this.timestamp,
    required this.errorCode,
    required this.errorMessage,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      timestamp: json['timestamp'],
      errorCode: json['error_code'],
      errorMessage: json['error_message'],
    );
  }
}