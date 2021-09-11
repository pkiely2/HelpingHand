part of screens;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription<DataConnectionStatus> listener;
  TextEditingController myUserNameController;
  TextEditingController myPwdController;
  ConnectionStateDialog customDialogBoxState;
  ScrollController controller;
  double offset = 0;
  bool passwordInvisible = true;
  bool passValidateText = false;
  bool userNameValidateText = false;
  bool validEmailVisible = false;
  bool connected = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueGrey,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 80, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
              Card(
                child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.only(right: 10, top: 10),
                          child: Image.asset("assets/icons/helpinghand.png"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(35),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil().setHeight(15),
                            ),
                            Text("Email",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: ScreenUtil().setSp(26))),
                            TextField(
                              controller: myUserNameController,
                              decoration: InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                                errorText: userNameValidateText ? 'Email Can\'t Be Empty' : null,
                                errorStyle: TextStyle(color: Colors.red, fontSize: 15.0),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Text("Password",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: ScreenUtil().setSp(26))),
                            TextFormField(
                              controller: myPwdController,
                              obscureText: passwordInvisible,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordInvisible = (passwordInvisible ? false : true);
                                    });
                                  },
                                  icon: Icon(
                                    passwordInvisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Enter your password",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                                errorText: passValidateText ? 'Password Can\'t Be Empty' : null,
                                errorStyle: TextStyle(color: Colors.red, fontSize: 15.0),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(35),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            width: ScreenUtil().setWidth(330),
                            height: ScreenUtil().setHeight(40),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: kActiveShadowColor,
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {

                                  if(myUserNameController.text.isEmpty){
                                    setState(() {
                                      userNameValidateText = true;
                                    });
                                  }

                                  if(myPwdController.text.isEmpty){
                                    setState(() {
                                      passValidateText = true;
                                    });
                                  }

                                  if(!(myPwdController.text.isEmpty && myUserNameController.text.isEmpty)) {
                                    login();
                                  }


                                },
                                child: Center(
                                  child: Text("SIGN IN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 20,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              Column(
                children: <Widget> [
                  SizedBox(
                    height: ScreenUtil().setHeight(20.0),
                  ),
                  Text("Sign In With",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Poppins-Bold",
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20.0),
                  ),
                  Row(
                    children: <Widget> [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: 25.0, right: 16.0),
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setHeight(40),
                            decoration: BoxDecoration(
                                color: HexColor("#DB4437"),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: kActiveShadowColor,
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                    ]),
                            child: Row(
                              children: <Widget> [
                                Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width < 120 ? 24 : 18,
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15.0),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Authentication.signInWithGoogle(context: context);
                                    },
                                    child: Center(
                                      child: Text("Google",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: MediaQuery.of(context).size.width < 120 ? 15 : 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(20.0),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.only(left: 20.0),
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setHeight(40),
                            decoration: BoxDecoration(
                                color: HexColor("#4267B2"),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: kActiveShadowColor,
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Row(
                              children: <Widget> [
                                Icon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width < 120 ? 24 : 18,
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15.0),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                          Authentication.signInWithFacebook(context: context);
                                    },
                                    child: Center(
                                      child: Text("Facebook",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: MediaQuery.of(context).size.width < 130 ? 14 : 16,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ), Align(
                      alignment: Alignment.centerRight,
                    child: Container(
                      margin: new EdgeInsets.only(top: 10.0),
                      child:InkWell(
                        onTap: () {

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ForgotPassWordDialog();
                              }
                          );

                        },
                        child: Text("Forgot Password?",
                          style: TextStyle(
                            color: Color(0xFF5d74e3),
                            fontFamily: "Poppins-Bold",
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30.0),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontSize: 17.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15.0, bottom: 2.0),
                          child:InkWell(
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                            },
                            child: Text("Sign Up",
                              style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold",
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20.0),
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

  @override
  void dispose() {
    controller?.dispose();
    myPwdController?.dispose();
    myUserNameController?.dispose();
    listener?.cancel();
    super.dispose();

  }

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );



  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getToken().then((value) => FireStore.addToken(value)).onError((error, stackTrace) => print(error));

    customDialogBoxState = ConnectionStateDialog();

    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        case DataConnectionStatus.connected:
          if(connected){
            Navigator.pop(context);
            setState(() {
              connected = false;
            });
          }
          break;
        case DataConnectionStatus.disconnected:
          _showDialog();
          setState(() {
            connected = true;
          });
          break;
      }
    });
    this.controller = ScrollController();
    this.myUserNameController = TextEditingController();
    this.myPwdController = TextEditingController();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  void login() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: myUserNameController.text.toString(),
          password: myPwdController.text.toString()
      ).then((value) => {
        emailVerified(value.user, this.context),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBoxState(title: "No User Found", description: "No User Found With That Email Address", voidCallback: null);
            }
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBoxState(title: "Incorrect Login Details", description: "You're login details don't match our records. Please try again", voidCallback: null);
            }
        );
      } else if (e.code == 'invalid-email'){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBoxState(title: "Invalid Email Address", description: "Please enter a valid email address", voidCallback: null);
            }
        );
      }
    }
  }

  _showDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return customDialogBoxState;
        });
  }

  void emailVerified(User user, BuildContext context) async{
    if (user != null && !user.emailVerified) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return VerifyAccountDialog();
          }
      );
    }else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ProfileScreen(user: user)));
    }
  }

}

