part of dialogs;

class ForgotPassWordDialog extends StatefulWidget{

  ForgotPassWordDialog();
  
  @override
  _ForgotPassWordDialog createState() => _ForgotPassWordDialog();
}

class _ForgotPassWordDialog extends State<ForgotPassWordDialog> {

  final myEmailController = TextEditingController();
  bool userNameValidateText = false;
  bool txtSent = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  @override
  void dispose() {
    myEmailController.dispose();
    super.dispose();
  }
  
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Password Reset",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(25),
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
              SizedBox(height: 15),
              TextFormField(
                onChanged: (text) {
                  setState(() {
                    userNameValidateText = this.myEmailController.text.isEmpty;
                  });
                },
                controller: myEmailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                  errorText: userNameValidateText ? 'Email Can\'t Be Empty' : null,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              ),
              SizedBox(height: 15),
              Text(
                  'Enter your email address to reset you password',
                  style: TextStyle(fontSize: 12.0),
              ),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    width: 95,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        onPressed: (){

                            setState(() {
                              this.userNameValidateText = this.myEmailController.text.isEmpty;
                            });

                            if(this.myEmailController.text.isNotEmpty){
                                resetEmail();
                            }

                        },
                        textColor: Colors.white,
                        color: Colors.green,
                        child: Text('Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                    )
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  void resetEmail() async {
      FirebaseAuth.instance.sendPasswordResetEmail(email: myEmailController.text.toString()).then((value) => showConfirmDialog());
  }

  void showConfirmDialog(){
    Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBoxState(title: 'Email Sent',description: 'Please check your inbox for instructions how to reset your password');
          }
          );
  }
}
