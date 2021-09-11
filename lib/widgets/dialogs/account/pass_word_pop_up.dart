part of dialogs;

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class PassWordDialogPopUp extends StatefulWidget {


  final String title;
  final String description;
  final String email;
  final VoidCallback voidCallback;

  PassWordDialogPopUp({this.title, this.description, this.voidCallback, this.email});

  @override
  _PassWordDialogPopUp createState() => _PassWordDialogPopUp();
}

class _PassWordDialogPopUp extends State<PassWordDialogPopUp>{
  bool isGoogleTwoFactorEnabled = false;
  String mfaToken;
  String recoveryCode;

  @override
  void initState() {
    super.initState();
  }


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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  resetEmail();
                },
                child: Text('Send Password reset email', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Account Security",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Helping Hand uses Multi Factor Authentication to increase account security and protect user accounts by giving you a double layer of protection.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SwitchListTile(
                activeColor: Colors.blueAccent,
                contentPadding: const EdgeInsets.all(0),
                value: FirebaseAuth.instance.currentUser.emailVerified,
                title: Text("Email"),
                onChanged: (val) {
                },
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                        Navigator.of(context).pop();
                    },
                    child: Text('Close',style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
      ],
    );
  }


  void resetEmail() async{
    Navigator.of(context).pop();
    FirebaseAuth.instance.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser.email).then((value) => {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBoxState(
            title: "Email Sent",
            description: "Password Email Sent, Please Check your inbox and spam folder",
          );
        })
    });
  }




}
