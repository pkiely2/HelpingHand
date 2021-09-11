part of dialogs;

class LogOutDialog extends StatelessWidget {

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
              const Text("Log Out", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600, color: Colors.red)),
              SizedBox(height: 15,),
              const Text("Are You Sure You Want To Log Out",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text('Close',style: TextStyle(fontSize: 18),)
                  ),
                  FlatButton(
                      onPressed: (){
                        logoutAction();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            LoginScreen()), (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                      )
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    await secureStorage.delete(key: 'mfa_token');
  }
}
