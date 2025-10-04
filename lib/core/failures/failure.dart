abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('Server error occurred');
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}