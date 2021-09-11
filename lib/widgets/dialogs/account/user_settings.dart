part of dialogs;


class UserSettings extends StatefulWidget {

  UserSettings();

  @override
  _UserSettings createState() => _UserSettings();
}

class _UserSettings extends State<UserSettings>{

  TextEditingController transalteController;
  bool passValidateText = false;

  @override
  void initState() {
    this.transalteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    this.transalteController?.dispose();
    super.dispose();
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
                  "Update Username",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                child: TextFormField(
                  controller: transalteController,
                  decoration: InputDecoration(
                    hintText: FirebaseAuth.instance.currentUser.displayName != null ? FirebaseAuth.instance.currentUser.displayName : "Enter username you wish to use",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                    errorText: passValidateText ? 'Request Text Can\'t Be Empty' : null,
                    errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if(transalteController.text.isEmpty){
                          setState(() {
                            passValidateText = true;
                          });
                        }else{
                          setState(() {
                            passValidateText = false;
                          });
                          FireStore.updateUserName(context, this.transalteController.text).whenComplete(() => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new CustomDialogBoxState(title: 'Username Changed',description: "User name has been successfully changed to " + this.transalteController.text);
                                }),
                          });
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              ),
              const SizedBox(height: 20.0),
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void resetEmail() async{
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
