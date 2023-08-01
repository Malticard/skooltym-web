import '/exports/exports.dart';

class ForgotPasswordController extends Cubit<Map<String,dynamic>>{
  ForgotPasswordController():super({});
  void updateForgot(Map<String,dynamic> g){
    emit(g);
  }
}