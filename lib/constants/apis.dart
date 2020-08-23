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
  //static const anonymousFacDet = 'faculties';
//Login
  static const loginApi = 'login';
//Logout
  static const logoutApi = 'logout';
//Register Student
  static const registerApi = 'register';
//Faculty Post API
  // static const facultyPost = 'post';

  //Anonymous API Section...

  //Anonymous Home API
  static const anonymousHomePage = 'https://us-central1-bridge-fd58f.cloudfunctions.net/anonymous/home' ;


  //Student API Section...

  //Student Register
  static const studentRegister = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/register';

  //Student Login
  static const studentLogin = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/login';

  //Student Home API
  static const studentHome = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/home';

  //Getting the Profile of a Student
  static const studentProfile = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/profile';

  //Student Logout
  static const studentLogout = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/logout';

  //Like a Post
  static const studentLike = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/like';

  //Comment a Post
  static const studentComment = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/comment';

  //Bookmark a Post
  static const studentSave = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/bookmark';

  //Get the comments of a Post
  static const studentGetComment = 'https://us-central1-bridge-fd58f.cloudfunctions.net/student/getComments';

  
  //Faculty API Section...

  //Faculty Register
  static const facultyRegister = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/register';

  //Faculty Login
  static const facultyLogin = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/login';

  //Faculty Home API
  static const facultyHome = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/home';

  //Getting the Profile of a Faculty
  static const facultyProfile = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/profile';

  //Faculty Logout
  static const facultyLogout = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/logout';

  //Like a Post
  static const facultyLike = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/like';

  //Comment a Post
  static const facultyComment = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/comment';

  //Bookmark a Post
  static const facultySave = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/bookmark';

  //Get Comments of a Post
  static const facultyGetComment = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/getComments';

  //Post
  static const facultyPost = 'https://us-central1-bridge-fd58f.cloudfunctions.net/faculty/post';


}
