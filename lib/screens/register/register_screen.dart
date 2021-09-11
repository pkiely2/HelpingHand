part of screens;

class RegisterScreen extends StatefulWidget{

  RegisterScreen();

 @override
  _RegisterScreenState createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen>{

  final controller = ScrollController();
  final myPwdController = TextEditingController();
  final myUserNameController = TextEditingController();
  final myPwdConfirmController = TextEditingController();
  final myEmailController = TextEditingController();
  bool passwordInvisible = true;
  bool passValidateText = false;
  bool userNameValidateText = false;
  bool passConfirmValidateText = false;
  bool userEmailValidateText = false;
  bool passWordsDontMatch = false;
  bool minLenght = false;
  bool specialChar = false;
  bool lowerChar = false;
  bool upperChar = false;
  bool hasDigit = false;
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 12, right: 12, left: 12, top: 35),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Return', style: TextStyle(fontSize: 18.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Register",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(35),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil().setHeight(15),
                            ),
                            Text("User Name",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: ScreenUtil().setSp(26))),
                            TextField(
                              controller: myUserNameController,
                              onChanged: (text) {
                                if(text.isNotEmpty){
                                  setState(() {
                                    userNameValidateText = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter a username",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                                errorText: userNameValidateText ? 'UserName Can\'t Be Empty' : null,
                                errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            Text("Email",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: ScreenUtil().setSp(26))),
                            TextFormField(
                              controller: myEmailController,
                              decoration: InputDecoration(
                                hintText: "Enter an email",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                                errorText: userEmailValidateText ? 'Email Can\'t Be Empty' : (myEmailController.text.isEmpty ? null : validateEmai() ?  null : "Incorrect email format"),
                                errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            Text("PassWord",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: ScreenUtil().setSp(26))),
                            TextFormField(
                              onChanged: (text){
                                verifyPassWord(text);
                                if(text.isNotEmpty){
                                  setState(() {
                                    passValidateText = false;
                                  });
                                }
                              },
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
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                                errorText: passValidateText ? 'Password Can\'t Be Empty' : (passWordsDontMatch ? "Passwords Don't Match" :null),
                                errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            Text("Confirm PassWord",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: ScreenUtil().setSp(26))),
                            TextFormField(
                              controller: myPwdConfirmController,
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
                                hintText: "Confirm your password",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                                errorText: passValidateText ? 'Password Can\'t Be Empty' : null,
                                errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(35),
                            ),
                            validate(minLenght, "Password is at least 8 characters"),
                            validate(upperChar, "Password contains upper character"),
                            validate(lowerChar, "Password contains lower character"),
                            validate(specialChar, "Password contains special character"),
                            validate(hasDigit, "Password contains a digit"),
                            SizedBox(
                              height: ScreenUtil().setHeight(35),
                            ),
                          ],
                        ),
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
                                height: ScreenUtil().setHeight(50),
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
                                        userNameValidateText = !userNameValidateText;
                                      });
                                    }

                                    if(myPwdController.text.isEmpty){
                                      setState(() {
                                        passValidateText = !passValidateText;
                                      });
                                    }

                                    if(!passWordMatch()){
                                      setState(() {
                                        passWordsDontMatch = !passWordsDontMatch;
                                      });
                                    }


                                    if(!(myPwdController.text.isEmpty && myUserNameController.text.isEmpty) && passWordConfirms() && passWordMatch() && validateEmai()) {
                                        createUser();
                                    }
                                  },
                                  child: Center(
                                      child: Text("Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
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

  Widget validate(bool val, String txt) => Row(
    children: <Widget>[
      Icon(val ? LineAwesomeIcons.check : Icons.close_outlined, color: val ? Colors.green : Colors.red),
      SizedBox(width: 5.0),
      Text(txt,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: ScreenUtil().setSp(12),
            color: val ? Colors.green : Colors.red,
          )
      ),
    ],
  );

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  void verifyPassWord(String pwd){

    if(pwd.length >= 8){
      setState(() {
        this.minLenght = true;
      });
    }else{
      setState(() {
        this.minLenght = false;
      });
    }

    if(new RegExp(r'^(?=.*?[a-z])').hasMatch(pwd)){
      setState(() {
        this.lowerChar = true;
      });
    }else{
      setState(() {
        this.lowerChar = false;
      });
    }

    if(new RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)){
      setState(() {
        this.upperChar = true;
      });
    }else{
      setState(() {
        this.upperChar = false;
      });
    }

    if(new RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(pwd)){
      setState(() {
        this.specialChar = true;
      });
    }else{
      setState(() {
        this.specialChar = false;
      });
    }

    if(new RegExp(r'^(?=.*?[0-9])').hasMatch(pwd)){
      setState(() {
        this.hasDigit = true;
      });
    }else{
      setState(() {
        this.hasDigit = false;
      });
    }

  }

  bool validateEmai(){
    return new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this.myEmailController.text);
  }


  bool passWordConfirms(){
    return new RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z](?=.*?[0-9]))(?=.*?[!@#\$&*~]).{8,}$').hasMatch(this.myPwdController.text);
  }

  bool passWordMatch(){
    return this.myPwdConfirmController.text == this.myPwdController.text;
  }

  void createUser() async{
    try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myEmailController.text.toString(),
          password: myPwdController.text.toString(),
        ).then((value) => {
          value.user.updateDisplayName(this.myUserNameController.text).whenComplete(() => {
              value.user.sendEmailVerification().whenComplete(() => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBoxState(
                        title: "Sign Up Successful",
                        description: "You created your account successfully on Helpinghand, a verification email has been sent to your email account please verify your address before using your account",
                      );
                    }
                ).then((value) => {
                  Navigator.of(context).pop()
                })
              })
          }
        ),
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'weak-password') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBoxState(
                  title: "Weak Password",
                  description: "This password doesn\'t meet our requirements",
                );
              }
          );
        } else if (e.code == 'email-already-in-use') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBoxState(
                  title: "Account Exists",
                  description: "This email address is already in use, please sign in or reset you're password if you forgot you're login credentials",
                );
              }
          );
        }
      } catch (e) {
        print(e);
      }
  }

  @override
  void dispose() {
    controller?.dispose();
    myPwdController?.dispose();
    myUserNameController?.dispose();
    myPwdConfirmController?.dispose();
    myEmailController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }
}