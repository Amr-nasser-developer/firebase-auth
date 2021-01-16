abstract class LoginStates{}

class LoginInitial extends LoginStates{}

class LoginLoading extends LoginStates{}

class LoginSuccess extends LoginStates{
  final token;
  LoginSuccess(this.token);
}

class LoginError extends LoginStates{
  final error;
  LoginError(this.error);
}