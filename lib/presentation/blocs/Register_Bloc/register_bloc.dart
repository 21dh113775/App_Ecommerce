import 'package:bloc/bloc.dart';
import 'package:ecommerce/presentation/blocs/Register_Bloc/register_event.dart';
import 'package:ecommerce/presentation/blocs/Register_Bloc/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterWithEmail>(_onRegisterWithEmail);
    on<RegisterWithGoogle>(
        _onRegisterWithGoogle); // Xử lý sự kiện Google Sign-In
  }

  Future<void> _onRegisterWithEmail(
      RegisterWithEmail event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  // Xử lý logic Google Sign-In
  Future<void> _onRegisterWithGoogle(
      RegisterWithGoogle event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(RegisterFailure('Google sign-in canceled'));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure('Google sign-in failed: $e'));
    }
  }
}
