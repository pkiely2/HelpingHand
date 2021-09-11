part of dialogs;

class LoginExceptionDialog extends StatelessWidget {

  final String type;
  final List<String> logins;
  LoginExceptionDialog({this.type, this.logins});

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
              Text("Account With This Email Already Exists", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text("Login With Your Current Account, Once Logged In The New Method Will Be Automatically Linked",style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              if(type == "google" && logins.contains("google.com"))
                  TextButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width < 120 ? 24 : 18,
                    ),
                    label: Text("Google"),
                    onPressed: () => Navigator.pop(context, "google.com"),
                ),
              SizedBox(height: 15,),
              if(type == "facebook" && logins.contains("facebook.com"))
                TextButton.icon(
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width < 120 ? 24 : 18,
                  ),
                  label: Text("Facebook"),
                  onPressed: () => Navigator.pop(context, "facebook.com"),
                ),

            ],
          ),
        ),
      ],
    );
  }
}
