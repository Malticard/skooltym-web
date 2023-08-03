import 'package:admin/exports/exports.dart';
import 'package:admin/models/StudentModel.dart';

import '../models/DropOffModels.dart';
import '../models/Guardians.dart';

// function to search for students
Future<StudentModel> searchStudents(String schoolId, String query) async {
  Response response = await Client()
      .get(Uri.parse(AppUrls.searchStudents + schoolId + "?query=" + query));
  return studentModelFromJson(response.body);
}
// function to search for staff
Future<StaffModel> searchStaff(String schoolId, String query) async {
  Response response = await Client()
      .get(Uri.parse(AppUrls.searchStaff + schoolId + "?query=" + query));
  return staffModelFromJson(response.body);
}

// function to search for classes
Future<ClassModel> searchClasses(String schoolId, String query) async {
  Response response = await Client()
      .get(Uri.parse(AppUrls.searchClass + schoolId + "?query=" + query));
  return classModelFromJson(response.body);
}

// function to search for guardians
Future<Guardians> searchGuardians(String schoolId, String query) async {
  Response response = await Client()
      .get(Uri.parse(AppUrls.searchGuardians + schoolId + "?query=" + query));
  return gaurdiansFromJson(response.body);
}

// function to search for Streams
Future<StreamsModel> searchStreams(String schoolId, String query) async {
  Response response = await Client()
      .get(Uri.parse(AppUrls.searchStreams + schoolId + "?query=" + query));
  return streamsModelFromJson(response.body);
}
// function to search for pickups
Future<PickUpModel> searchPickups(String schoolId, String query) async {
  Response response = await Client()
      .get(Uri.parse(AppUrls.searchPickUps + schoolId + "?query=" + query));
  return pickUpModelFromJson(response.body);
}

// function to search for dropoffs
Future<DropOffModel> searchDropOffs(String schoolId, String query) async {
  Response response = await Client()
      .get(Uri.parse(AppUrls.searchDropOffs + schoolId + "?query=" + query));
  return dropOffModelFromJson(response.body);
}