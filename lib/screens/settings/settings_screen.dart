part of screens;

class SettingsScreen extends StatefulWidget{

  SettingsScreen();

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen>{

  String nickName = "Nickname";
  String email = "Email";
  String pic = "Picture";
  bool isEmailVerified = false;
  bool showEditButton = false;


  @override
  initState() {
    setState(() {
      this.nickName = (FirebaseAuth.instance.currentUser.displayName != null ? (FirebaseAuth.instance.currentUser.displayName.isNotEmpty ? FirebaseAuth.instance.currentUser.displayName : "Update UserName In Settings") : "Update UserName In Settings");
      this.email = FirebaseAuth.instance.currentUser.email;
      this.isEmailVerified = FirebaseAuth.instance.currentUser.emailVerified;
    });
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: !globals.isDark ? null : Colors.grey.shade900,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: IconTheme(
                  data: new IconThemeData(
                      color: globals.isDark ? Colors.white54 : Colors.grey.shade900),
                  child: new Icon(Icons.menu),
                ),
                onPressed: (){
                  if(ZoomDrawer.of(context).isOpen()){
                    ZoomDrawer.of(context).close();
                  }else{
                    ZoomDrawer.of(context).open();
                  }
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10),
                          AvatarImage(),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  this.nickName.contains(" ") ? this.nickName.replaceAll(" ", "\n") : this.nickName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Poppins"),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UserSettings();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            this.email,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Poppins"),
                          ),
                          Text(
                            'Email Verified: ' + (this.isEmailVerified ? "True" : "False"),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(height: 10.0),
                          ListTile(
                            leading: Icon(
                              Icons.lock_outline,
                              color: Colors.blueAccent,
                            ),
                            title: Text("Password & Security"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PassWordDialogPopUp();
                                },
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.close,
                              color: Colors.blueAccent,
                            ),
                            title: Text("Close Account"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DeleteAccountDialog();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    SizedBox(height: 15),
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Column(
                          children: [
                            Align(
                              child: Text(
                                "Application Settings",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SwitchListTile(
                              activeColor:  Colors.blueAccent,
                              contentPadding: const EdgeInsets.all(0),
                              value: (Platform.isAndroid),
                              title: Text("Receive Notifications"),
                              onChanged: (val) {
                                if(Platform.isIOS){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return new CustomDialogBoxState(title: 'Feature Not Available',description: "This feature is not yet available on iOS devices. To disable or enable firebase.notifications on iOS devices please go to Device Settings -> Scroll Down To Sense -> Notifications and Allow Or Disallow Notifications.");
                                      });
                                }else if(Platform.isAndroid){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return new CustomDialogBoxState(title: 'Feature Not Available',description: "This feature is not yet available on Android devices. To disable or enable firebase.notifications on Android Devise devices please go to Device Settings -> Scroll Down To Sense -> Notifications and Allow Or Disallow Notifications.");
                                      });
                                }
                              },
                            ),
                            SwitchListTile(
                              activeColor: Colors.blueAccent,
                              contentPadding: const EdgeInsets.all(0),
                              value: false,
                              title: Text("Received App Updates"),
                              onChanged: (val){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return new CustomDialogBoxState(title: "Feature In Development",description: "Feature is still in active development by our team and will be available within the next update");
                                    });
                              },
                            ),
                            const SizedBox(height: 10.0),
                            Align(
                              child: Text(
                                "Background Theme",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            SwitchListTile(
                              activeColor: Colors.blueAccent,
                              contentPadding: const EdgeInsets.all(0),
                              value: globals.isDark,
                              title: Text("Dark"),
                              onChanged: (val) {
                                setState(() {
                                  globals.isDark = !globals.isDark;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}


class AvatarImage extends StatelessWidget {

  const AvatarImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: FirebaseAuth.instance.currentUser.photoURL != null ? (FirebaseAuth.instance.currentUser.photoURL.isNotEmpty ?  Image.network(FirebaseAuth.instance.currentUser.photoURL).image : AssetImage("assets/images/kermit.jpg")) :  AssetImage("assets/images/kermit.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

