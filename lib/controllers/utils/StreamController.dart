import '/exports/exports.dart';
class StreamsController with ChangeNotifier{
  List<StreamModel> streams = [];

  
  Future<void> getStreams(String school) async {
    // function to fetch streams
       streams = await fetchStreams(school);
       notifyListeners();
     
  }
}