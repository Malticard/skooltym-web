import '/exports/exports.dart';
class StreamsController extends Cubit<List<StreamModel>>{
  StreamsController() : super([]);
  void getStreams(BuildContext ctx){
    fetchStreams(ctx.read<SchoolController>().state['school']).then((value) {
      emit(value);
    });
  }
}