// Login API's
class Api {
  static const student =
      'https://us-central1-bridge-fd58f.cloudfunctions.net/student/';
  static const faculty =
      'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/';
  static const anonymous =
      'https://us-central1-bridge-fd58f.cloudfunctions.net/anonymous/';
//Anonymous User Home Page
  static const anonymousHome = 'home';
//Anonymous User to get Faculties Details
  static const anonymousFacDet = 'faculties';
//Login
  static const loginApi = 'login';
//Logout
  static const logoutApi = 'logout';
//Register Student
  static const registerApi = 'register';
//Faculty Post API
  static const facultyPost = 'post';
}
