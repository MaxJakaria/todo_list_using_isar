class Failure {
  final String message;

  Failure([this.message = 'An unexpected error occurred']);
}

class ServerFailure extends Failure {
  ServerFailure({String message = 'Server Error'}) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure({String message = 'Catch Error'}) : super(message);
}
