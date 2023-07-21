import '/exports/exports.dart';

class ClassController with ChangeNotifier {
  List<ClassModel> classes = [];
  Timer? _timer;

  void getClasses(String schoolId)  {
    Client().get(Uri.parse(AppUrls.getClasses + schoolId)).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        classes = classModelFromJson(response.body);
        notifyListeners();
      }
    });
  }

  void clearCache() {
    _timer?.cancel();
  }
}
