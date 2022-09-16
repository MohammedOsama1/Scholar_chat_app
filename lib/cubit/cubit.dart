import 'package:chat_app/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  bool isPass = false ;
  CollectionReference messages = FirebaseFirestore.instance.collection('Messages');
  Future register(emailController, passController) async {
    emit(RegisterLoading());
    final auth = FirebaseAuth.instance;
    await auth
        .createUserWithEmailAndPassword(
            email: emailController, password: passController)
        .then((value) {
      emit(RegisterSucStates());
    }).catchError((error){
      emit(RegisterErrorStates(error.toString()));
    });
  }
  Future login (emailController, passController) async {
    emit(LoginLoading());
    var auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: emailController, password: passController).then((value) {
      emit(LoginSucStates());
    }).catchError((error){
      emit(LoginErrorStates(error.toString()));
    });
  }
  void showPassword (){
if(isPass== true){isPass=false;}else{isPass= true;}
print(isPass);
    emit(ShowPassState());
  }
  Future sendingMessage (String data,String email) async {
    await messages.add({
      'message':data,
      'CreatedAt' : DateTime.now(),
      'email' : email
    }).then((value) {emit(SendingMessageSucState());
    }).catchError((onError){emit(SendingMessageErrorState());});
  }

}
