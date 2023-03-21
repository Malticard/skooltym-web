class AppUrls {
  static String devURL = "http://127.0.0.1:5058/";
  //"https://skooltym-backend-production.up.railway.app/";
  static String imageUrl = "assets/images/";
  static String iconUrl = "assets/icons/";
  // post urls
  static String login = devURL + "post/login";
  static String addStaff = devURL + "post/staff/create";
  static String addSchool = devURL + "post/schools/create";
  static String addStudent = devURL + "post/students/create";
  static String addGuardian = devURL + "post/guardians/create";
  static String addSettings = devURL + "post/settings/create";
  static String addPickUp = devURL + "post/pickup/create";
  static String addDropOff = devURL + "post/dropoff/create";
  static String registerOvertime = devURL + "post/overtime/create";
  // static String registerOvertime = devURL + "post/overtime/create";
  // get urls
  static String roles = devURL + "get/roles";
  static String schools = devURL + "get/schools";
  static String students = devURL + "get/students";
  static String overtime = devURL + "get/overtime";
  static String staff = devURL + "get/staff";
  static String settings = devURL + "get/settings";
  static String years = devURL + "get/years";
  static String getStudents = devURL + "get/students";
  static String getPickUps = devURL + "get/pickup";
  static String getDropOffs = devURL + "get/dropoff";
  // fetch specific
  static String getGuardian = devURL + "specific/guardians/";
  static String getStudent = devURL + "specific/students/";
  static String pickUps = devURL + "specific/pickup/";
  static String dropOffs = devURL + "specific/dropoff/";
  static String getOtherGaurdians = devURL + "specific/otherGuardians/";
}
// constants