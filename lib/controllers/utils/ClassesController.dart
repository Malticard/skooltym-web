import '/exports/exports.dart';
class ClassController with ChangeNotifier {
List<ClassModel> _classes = [];
Timer? _timer;
List<ClassModel> get classes => _classes;
 Future<void> getClasses(String schoolId) async {
    Response response = await Client().get(Uri.parse(AppUrls.getClasses + schoolId));
      if (response.statusCode == 200 || response.statusCode == 201) {
       _classes = classModelFromJson(response.body);
       notifyListeners();
      }
}

void clearCache(){
  _timer?.cancel();
}
}