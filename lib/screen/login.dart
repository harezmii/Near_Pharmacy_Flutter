import 'package:arayanbulur/screen/shared_preference_processing.dart';
import 'package:arayanbulur/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _emailController;
  TextEditingController _passController;
  TextEditingController _email1Controller;
  TextEditingController _pass1Controller;
  TextEditingController _passAgainController;

  isUserLogin() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("Kullanıcı Yok");
    } else {
      setState(() {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();

    _tabController = new TabController(length: 2, initialIndex: 0, vsync: this);
    _emailController = new TextEditingController();
    _email1Controller = new TextEditingController();
    _passController = new TextEditingController();
    _pass1Controller = new TextEditingController();
    _passAgainController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  width: 200,
                  child: TabBar(
                    indicatorColor: Colors.black54,
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    onTap: (i) {},
                    automaticIndicatorColorAdjustment: false,
                    tabs: [
                      Tab(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  child: Icon(
                    Icons.emoji_people_sharp,
                    color: Colors.white,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(top: 100, left: 0),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "Welcome Back !",
                                style:
                                    TextStyle(fontSize: 24, letterSpacing: 1.0),
                              ),
                              margin: EdgeInsets.only(right: 120),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: 220,
                                left: 0,
                              ),
                              child: Text(
                                "ChatTo",
                                style: TextStyle(
                                    fontSize: 24,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 40),
                              child: Column(
                                children: [
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(6),
                                          icon: Icon(
                                            Icons.email_outlined,
                                            color: Colors.black54,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                          focusColor: Colors.black54,
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintText: "Enter the email",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                    ),
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: _passController,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.lock_open_outlined,
                                            color: Colors.black54,
                                          ),
                                          contentPadding: EdgeInsets.all(6),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintText: "Enter the password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                    ),
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                  ),
                                ],
                              ),
                            ),

                            // icons
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                                left: 30,
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.facebookF,
                                      color: Colors.black,
                                    ),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.googlePlusG,
                                      color: Colors.black,
                                      size: 32,
                                    ),
                                    onTap: () {
                                      var userCredential = signInWithGoogle();
                                      userCredential
                                          .onError((error, stackTrace) {
                                        Toast.show("Hata var", context,
                                            gravity: Toast.BOTTOM);
                                        return error;
                                      });
                                      userCredential.whenComplete(() {
                                        Toast.show(
                                            "Hesap Seçilemedi! > Giriş yapmak için hesap seçmelisiniz <",
                                            context,
                                            gravity: Toast.BOTTOM);
                                      });
                                      userCredential.then(
                                        (value) async {
                                          if (value.credential != null) {
                                           await SharedPreferencesProcessing().setPrefIsLogin(true);

                                            Toast.show("Başarılı", context,
                                                gravity: Toast.BOTTOM);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SplashScreen(),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // end icons

                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    bottom: 70,
                                    left: 40,
                                  ),
                                  Positioned(
                                    child: Container(
                                      height: 60,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    bottom: 0,
                                  ),
                                  Positioned(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_emailController
                                                .value.text.isNotEmpty &&
                                            _passController
                                                .value.text.isNotEmpty) {
                                          try {
                                            UserCredential userCredential =
                                                await FirebaseAuth.instance
                                                    .signInWithEmailAndPassword(
                                              email:
                                                  _emailController.value.text,
                                              password:
                                                  _passController.value.text,
                                            );
                                            if (userCredential != null) {
                                              if (!FirebaseAuth.instance
                                                  .currentUser.emailVerified) {
                                                Toast.show(
                                                    "Email onaylayın", context,
                                                    gravity: Toast.BOTTOM);

                                                FirebaseAuth
                                                    .instance.currentUser
                                                    .sendEmailVerification();
                                              } else {
                                                Toast.show(
                                                    "Giriş Başarılı", context,
                                                    gravity: Toast.BOTTOM);
                                                Navigator.pushNamed(
                                                    context, "/home");
                                              }
                                            }
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'user-not-found') {
                                              Toast.show(
                                                  "Bu email adresi bulunamadı",
                                                  context,
                                                  gravity: Toast.BOTTOM);
                                            } else if (e.code ==
                                                'wrong-password') {
                                              Toast.show(
                                                  "Şifre yanlış", context,
                                                  gravity: Toast.BOTTOM);
                                            }
                                          }
                                        } else {
                                          Toast.show("Alanları boş bırakmayın",
                                              context,
                                              gravity: Toast.BOTTOM);
                                        }
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                        height: 50,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.orange.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ),
                                    ),
                                    bottom: 32,
                                    right: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(top: 100, left: 0),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "Hello ChatTos !",
                                style:
                                    TextStyle(fontSize: 24, letterSpacing: 1.0),
                              ),
                              margin: EdgeInsets.only(right: 120),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: 220,
                                left: 0,
                              ),
                              child: Text(
                                "ChatTo",
                                style: TextStyle(
                                    fontSize: 24,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 40),
                              child: Column(
                                children: [
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _email1Controller,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(6),
                                          icon: Icon(
                                            Icons.email_outlined,
                                            color: Colors.black54,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                          focusColor: Colors.black54,
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintText: "Enter the email",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                    ),
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: _pass1Controller,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.lock_open_outlined,
                                            color: Colors.black54,
                                          ),
                                          contentPadding: EdgeInsets.all(6),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintText: "Enter the password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                    ),
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: _passAgainController,
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.lock_open_outlined,
                                            color: Colors.black54,
                                          ),
                                          contentPadding: EdgeInsets.all(6),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                          labelText: "Password Again",
                                          labelStyle: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintText: "Enter the password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                    ),
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                  ),
                                ],
                              ),
                            ),

                            // icons
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                                left: 30,
                              ),
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.googlePlusG,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                ],
                              ),
                            ),
                            // end icons

                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Container(
                                      height: 60,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    bottom: 0,
                                  ),
                                  Positioned(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_email1Controller
                                                .value.text.isNotEmpty &&
                                            _pass1Controller
                                                .value.text.isNotEmpty &&
                                            _passAgainController
                                                .value.text.isNotEmpty) {
                                          if (_pass1Controller.value.text
                                                  .toString() ==
                                              _passAgainController.value.text
                                                  .toString()) {
                                            try {
                                              await FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                      email: _email1Controller
                                                          .value.text,
                                                      password: _pass1Controller
                                                          .value.text);
                                            } on FirebaseAuthException catch (e) {
                                              if (e.code == 'weak-password') {
                                                Toast.show(
                                                    "Parolanız Zayıf", context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.BOTTOM);
                                              } else if (e.code ==
                                                  'email-already-in-use') {
                                                Toast.show(
                                                    "Bu email kullanılıyor !",
                                                    context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.BOTTOM);
                                              }
                                            } catch (e) {
                                              Toast.show("Hata Var!", context,
                                                  duration: Toast.LENGTH_SHORT,
                                                  gravity: Toast.BOTTOM);
                                            }

                                            Toast.show(
                                                "Kayıt Oldunuz.Giriş Ekranına Yönlendiriliyorsunuz",
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                            _pass1Controller.text = "";
                                            _passAgainController.text = "";
                                            _email1Controller.text = "";
                                            Navigator.pushNamed(context, "/");
                                          } else {
                                            Toast.show(
                                                "Girdiğiniz Şifreler Uyuşmuyor.Kontrol Ediniz!",
                                                context,
                                                duration: Toast.LENGTH_SHORT,
                                                gravity: Toast.BOTTOM);
                                          }
                                        } else {
                                          Toast.show(
                                              "Alanları boş bırakmayınız",
                                              context,
                                              duration: Toast.LENGTH_SHORT,
                                              gravity: Toast.BOTTOM);
                                        }
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.arrow_right_alt_sharp,
                                          size: 32,
                                          color: Colors.white,
                                        ),
                                        height: 50,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ),
                                    ),
                                    bottom: 32,
                                    right: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
