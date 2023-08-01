import '/exports/exports.dart';

class ClassController with ChangeNotifier {
  List<Classes> classes = [];
  Timer? _timer;

  void getClasses(String schoolId)  {
    Client().get(Uri.parse(AppUrls.getClasses + schoolId)).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var cls  = classModelFromJson(response.body);
        classes = cls.classes;
        notifyListeners();
      }
    });
  }

  void clearCache() {
    _timer?.cancel();
  }
}
