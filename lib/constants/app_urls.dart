class AppUrls {
  static String devURL = "http://13.127.169.59:5050/";
  //"https://skooltym-backend-production.up.railway.app/";  http://13.127.169.59:5050/get/students/
  static String imageUrl = "assets/images/";
  static String iconUrl = "assets/icons/";
  static String liveImages = "http://13.127.169.59:5050/image/images/";
  // post urls
  static String login = "${devURL}post/staff-login";
  static String addClass = "${devURL}post/class/create";
  static String addStaff = "${devURL}post/staff/create";
  static String addSchool = "${devURL}post/schools/create";
  static String addStudent = "${devURL}post/students/create";
  static String addGuardian = "${devURL}post/guardians/create";
  static String addSettings = "${devURL}post/settings/create";
  static String addPickUp = "${devURL}post/pickup/create";
  static String addDropOff = "${devURL}post/dropoff/create";
  static String registerOvertime = "${devURL}post/overtime/create";
  static String addStream = "${devURL}post/stream/create";
  // static String registerOvertime = devURL + "post/overtime/create";
  // get urls
  static String roles = "${devURL}get/roles/";
  static String schools = "${devURL}get/schools";
  static String students = "${devURL}get/students/";
  static String overtime = "${devURL}get/overtime/";
  static String staff = "${devURL}get/staff/";
  static String settings = "${devURL}get/settings/";
  static String years = "${devURL}get/years/";
  static String getStudents = "${devURL}get/students/";
  static String getGuardians = "${devURL}get/guardians/";
  static String getPickUps = "${devURL}get/pickup/";
  static String getDropOffs = "${devURL}get/dropoff/";
  static String getClasses = "${devURL}get/class/";
  // fetch specific
  static String specficOvertime = "${devURL}specific/overtime/";
  static String getGuardian = "${devURL}specific/guardians/";
  static String getStudent = "${devURL}specific/students/";
  static String pickUps = "${devURL}specific/pickup/";
  static String dropOffs = "${devURL}specific/dropoff/";
  static String getOtherGaurdians = "${devURL}specific/otherGuardians/";
  // delete
  static String deleteStaff = "${devURL}delete/staff/";
  static String deleteStudent = "${devURL}delete/students/";
  static String deleteGuardian = "${devURL}delete/guardians/";
  static String deletePickUp = "${devURL}delete/pickup/";
  static String deleteDropOff = "${devURL}delete/dropoff/";
  static String deleteClass = "${devURL}delete/class/";
  // update
  static String updateStaff = "${devURL}update/staff/";
  static String updateStudent = "${devURL}update/students/";
  static String updateGuardian = "${devURL}update/guardians/";
  static String updatePickUp = "${devURL}update/pickup/";
  static String updateDropOff = "${devURL}update/dropoff/";
  static String updateClass = "${devURL}update/class/";
  static String updateSettings = "${devURL}update/settings/";
  static String updateOvertime = "${devURL}update/overtime/";
// 
static String setPass = "${devURL}password/set-password/";
static String forgotPassword = "${devURL}password/forgot-password";
static String verifyOtp = "${devURL}password/get-otp/";
static String setPassword = "${devURL}password/set-password/";
static String results = "${devURL}results/scanned-results/";
}

