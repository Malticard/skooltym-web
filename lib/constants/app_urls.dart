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
  static String addPayment = "${devURL}post/payments/create";
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
  static String getStreams = "${devURL}get/stream/";
  static String getPayment = "${devURL}get/payments/";
  // fetch specific
  static String specficOvertime = "${devURL}specific/overtime/";
  static String getGuardian = "${devURL}specific/guardians/";
  static String getStudent = "${devURL}specific/students/";
  static String pickUps = "${devURL}specific/pickup/";
  static String specificDropOffs = "${devURL}specific/dropoff/";
  static String getOtherGuardians = "${devURL}specific/otherGuardians/";
  static String specificClass = "${devURL}specific/class/";
  static String specificStream = "${devURL}specific/stream/";
  static String specificPayment = "${devURL}specific/payments/";

  // delete
  static String deleteStaff = "${devURL}delete/staff/";
  static String deleteStudent = "${devURL}delete/students/";
  static String deleteGuardian = "${devURL}delete/guardians/";
  static String deletePickUp = "${devURL}delete/pickup/";
  static String deleteDropOff = "${devURL}delete/dropoff/";
  static String deleteClass = "${devURL}delete/class/";
  static String deleteStream = "${devURL}delete/stream/";
  static String deletePayment = "${devURL}delete/payments/";
  // update
  static String updateStaff = "${devURL}update/staff/";
  static String updateStudent = "${devURL}update/students/";
  static String updateGuardian = "${devURL}update/guardians/";
  static String updatePickUp = "${devURL}update/pickup/";
  static String updateDropOff = "${devURL}update/dropoff/";
  static String updateClass = "${devURL}update/class/";
  static String updateStream = "${devURL}update/stream/";
  static String updateSettings = "${devURL}update/settings/";
  static String updateOvertime = "${devURL}update/overtime/";
  static String updatePayment = "${devURL}update/payments/";
//
  static String setPass = "${devURL}password/set-password/";
  static String forgotPassword = "${devURL}password/forgot-password";
  static String verifyOtp = "${devURL}password/get-otp/";
  static String setPassword = "${devURL}password/set-password/";
  static String results = "${devURL}results/scanned-results/";
// dashboard
  static String dashboard = "${devURL}dashboard/data/";
// searches
  static String searchStudents = "${devURL}search/search-students/";
  static String searchStaff = "${devURL}search/search-staff/";
  static String searchGuardians = "${devURL}search/search-guardians/";
  static String searchClass = "${devURL}search/search-classes/";
  static String searchStreams = "${devURL}search/search-streams/";
  static String searchPickUps = "${devURL}search/search-pickups/";
  static String searchDropOffs = "${devURL}search/search-dropoffs/";
  static String searchPayments = "${devURL}search/search-payments/";
  static String searchClearedOvertime = "${devURL}search/cleared-overtime/";
  static String searchPendingOvertime = "${devURL}search/pending-overtime/";
// overtimes
  static String pendingOvertime = "${devURL}overtime/pending/";
  static String clearedOvertime = "${devURL}overtime/cleared/";
}
