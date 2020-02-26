import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authCheck();
  }

  Future<void> _authCheck() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', 'Sharan');
    var name = prefs.getString('user_name') ?? 'none';
    if (name != 'none') {
      _authorizeNow();
    }
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      if (await _localAuthentication.canCheckBiometrics) {
        try {
          isAuthorized = await _localAuthentication.authenticateWithBiometrics(
            localizedReason: "Authenticate to Login",
            useErrorDialogs: false,
            stickyAuth: true,
          );
        } on PlatformException catch (e) {
          print(e);
        }
      }
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        // _authorizedOrNot = "Authorized";
        Navigator.pushReplacementNamed(context, HomeViewRoute);
      } else {
        // _authorizedOrNot = "Not Authorized";
      }
    });
  }

  static const MAIN_COLOR = Color(0xFF303030);
  static const SIGNUP_LIGHT_RED = Color(0xffffc2a1);
  static const SIGNUP_RED = Color(0xffffb1bb);
  static const YELLOW = Color(0xff373b44);
  static const BLUE = Color(0xff4286f4);

  static const LinearGradient SIGNUP_BACKGROUND = LinearGradient(
    begin: FractionalOffset(0.0, 0.4), end: FractionalOffset(0.9, 0.7),
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: [0.1, 0.9],
    colors: [
      Color(0xff859398),
      Color(0xff283040),
    ],
  );

  static const LinearGradient SIGNUP_CARD_BACKGROUND = LinearGradient(
    tileMode: TileMode.clamp,
    begin: FractionalOffset.centerLeft,
    end: FractionalOffset.centerRight,
    stops: [0.1, 1.0],
    colors: [
      Color(0xffFBC6B6),
      Color(0xffF79B83),
    ],
  );

  static const LinearGradient SIGNUP_CIRCLE_BUTTON_BACKGROUND = LinearGradient(
    tileMode: TileMode.clamp,
    begin: FractionalOffset.centerLeft,
    end: FractionalOffset.centerRight,
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: [0.4, 1],
    colors: [Colors.black, Colors.black54],
  );

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: SIGNUP_BACKGROUND,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60.0, horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Center(
                        //   child: Image.asset(
                        //     SignUpImagePath.SignUpLogo,
                        //     height: _media.height / 7,
                        //   ),
                        // ),
                        Center(
                          child: FlutterLogo(),
                          heightFactor: 2,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "WELCOME BACK!",
                          style: TextStyle(
                            letterSpacing: 4,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Log in',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 40),
                        ),
                        Text(
                          'to continue.',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w200,
                              fontSize: 40),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: _media.height / 3.8,
                          decoration: BoxDecoration(
                            gradient: SIGNUP_CARD_BACKGROUND,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: inputText("USERNAME",
                                      'hristov123@gmail.com', _username, false),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Expanded(
                                    child: inputText(
                                        "PASSWORD", '******', _password, true)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: MAIN_COLOR),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () => print("Sign Up Tapped"),
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
              Positioned(
                bottom: _media.height / 6.3,
                right: 15,
                child: SignUpArrowButton(
                  // icon: IconData(0xe901, fontFamily: 'Icons'),
                  iconSize: 20,
                  onTap: () => print("SignIn Tapped"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputText(
    String fieldName,
    String hintText,
    TextEditingController controller,
    bool obSecure,
  ) {
    return TextField(
      style: TextStyle(height: 1.3),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: fieldName,
        labelStyle: TextStyle(
          fontSize: 22.0,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          height: 0,
        ),
        border: InputBorder.none,
      ),
      obscureText: obSecure,
    );
  }
}

class SignUpArrowButton extends StatelessWidget {
  // final IconData icon;
  final Function onTap;
  final double iconSize;
  final double height;
  final double width;
  final Color iconColor;

  SignUpArrowButton({
    // this.icon,
    this.iconSize,
    this.onTap,
    this.height = 50.0,
    this.width = 50.0,
    this.iconColor = const Color(0xFFdbedb0),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(0.0, 16.0)),
          ],
          gradient: LinearGradient(begin: FractionalOffset.centerLeft,
// Add one stop for each color. Stops should increase from 0 to 1
              stops: [
                0.2,
                1
              ], colors: [
            Color(0xff000000),
            Color(0xff434343),
          ]),
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
