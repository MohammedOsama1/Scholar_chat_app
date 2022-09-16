abstract class HomeStates {}

class InitialHomeStates extends HomeStates {}

class RegisterSucStates extends HomeStates {}

class RegisterErrorStates extends HomeStates {
  final String error;

  RegisterErrorStates(this.error);
}

class RegisterLoading extends HomeStates {}

class LoginSucStates extends HomeStates {}

class LoginErrorStates extends HomeStates {
  final String error;

  LoginErrorStates(this.error);
}

class LoginLoading extends HomeStates {}

class ShowPassState extends HomeStates {}

class SendingMessageSucState extends HomeStates {}

class SendingMessageErrorState extends HomeStates {}
