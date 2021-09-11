part of dialogs;


class VerifyAccountDialog extends StatelessWidget {

  VerifyAccountDialog();

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
              Text("Verification Email Sent",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text("Check your inbox and verify your email address before loging in",style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FlatButton(
                        onPressed: (){
                            Navigator.pop(context, true);
                          },
                          child: Text("Close",style: TextStyle(fontSize: 18),)),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                        onPressed: (){
                          Navigator.pop(context, true);
                          FirebaseAuth.instance.currentUser.sendEmailVerification().whenComplete(() => {
                                showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     return CustomDialogBoxState(
                                        title: "Verification Email Sent Successfully",
                                        description: "A verification email has been sent to your account please verify your address before using your account",
                                     );
                                  })}
                              ).then((value) => {
                                Navigator.of(context).pop()
                              });
                        },
                        child: Text("Resend",style: TextStyle(fontSize: 18),)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
