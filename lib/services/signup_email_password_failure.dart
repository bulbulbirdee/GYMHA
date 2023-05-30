class SignUpEmailPasswordFailure{
  final String message;

  const SignUpEmailPasswordFailure([this.message = "An Unknown error occured. "]);

  factory SignUpEmailPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpEmailPasswordFailure('Please enter a stronger password');
      case 'invalid-email':
        return const SignUpEmailPasswordFailure('Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const SignUpEmailPasswordFailure('An account already exists for this email address');
      case 'operation-not-allowed':
        return const SignUpEmailPasswordFailure('Operation is not allowed. Please contact support');
      case 'user-disabled':
        return const SignUpEmailPasswordFailure('This user has been disabled. Please contact support');
      default:
        return const SignUpEmailPasswordFailure();
    }
  }
}