import '/exports/exports.dart';

class FirstTimeUserController extends Cubit<bool>{
  FirstTimeUserController() : super(true);
  void setFirstTimeUser(bool checker,String role) {
    if (role == 'Admin') {
      SharedPreferences.getInstance().then((value) {
      value.setBool('firstTimeUser',checker );
    });
    } else {
      SharedPreferences.getInstance().then((value) {
      value.setBool('financeFirstTimeUser',checker );
    });
    }
    
    emit(checker);
  }
  // retrieve saved state
  void getFirstTimeUser(String role) {
   if (role == 'Admin') {
     SharedPreferences.getInstance().then((value) {
       emit(value.getBool('firstTimeUser') ?? true);
     });
   } else {
      SharedPreferences.getInstance().then((value) {
      emit(value.getBool('financeFirstTimeUser') ?? true);
    });
   }
  }
}