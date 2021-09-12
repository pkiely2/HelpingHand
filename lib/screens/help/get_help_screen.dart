part of screens;

class GetHelpScreen extends StatefulWidget {

  GetHelpScreen({Key key, User user}) : super(key: key);

  @override
  GetHelpScreenState createState() => GetHelpScreenState();

}

class GetHelpScreenState extends State<GetHelpScreen> {

  Stream<QuerySnapshot> responses;
  TextEditingController transalteController;
  bool passValidateText = false;

  @override
  void dispose() {
    transalteController?.dispose();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();
    this.transalteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: !globals.isDark ? null : Colors.grey.shade900,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children:[
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
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(top: 20, left: 30),
                            child: Text(
                              "Upload Your Translation Request",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        Container(
                          child: TextFormField(
                            controller: transalteController,
                            decoration: InputDecoration(
                              hintText: "Enter Text Request Here",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                              errorText: passValidateText ? 'Request Text Can\'t Be Empty' : null,
                              errorStyle: TextStyle(color: Colors.red, fontSize: 15.0),
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
                                    if(FirebaseAuth.instance.currentUser.displayName != null && FirebaseAuth.instance.currentUser.displayName.isNotEmpty){
                                      FireStore.addTranslation(null, "text", transalteController.text, FirebaseAuth.instance.currentUser.displayName, context);
                                    }else{
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return new CustomDialogBoxState(title: 'User Name Not Set',description: "You have to set your username name in settings before being able to post or respond to requests");
                                          });
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Or",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          child: Container(
                            width: ScreenUtil().setWidth(330),
                            height: ScreenUtil().setHeight(70),
                            child: InkWell(
                              onTap: () {
                                if(FirebaseAuth.instance.currentUser.displayName != null && FirebaseAuth.instance.currentUser.displayName.isNotEmpty){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        Camera(reply: false),
                                    ),
                                  );
                                }else{
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return new CustomDialogBoxState(title: 'User Name Not Set',description: "You have to set your username name in settings before being able to post or respond to requests");
                                      });
                                }
                              },
                              child: Icon(
                                Icons.cloud_upload,
                                color: Colors.black,
                                size: ScreenUtil().setHeight(80),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Record/Upload Video Of Your Sign",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.only(left: 20, right: 30),
                    child: Column(
                      children: [
                        Align(
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "Respond to Requests",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: globals.isDark ? Colors.white : Colors.black54
                              ),
                            ),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Divider(
                                  color: globals.isDark ? Colors.white : Colors.black54
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width/2)-20, right: 10),
                              child: Divider(
                                color: globals.isDark ? Colors.white : Colors.black54,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.only(left: 35, top: 10, right: 35),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: FireStore.readItems(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.connectionState == ConnectionState.waiting || streamSnapshot.data == null) {
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: CircularProgressIndicator(),
                            width: 100,
                            height: 100,
                          ),
                        );
                      }else {
                        return ListView.builder(
                          itemCount: streamSnapshot.data.docs.length,
                          itemBuilder: (ctx, index) =>
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            streamSnapshot.data.docs[index]['title'],
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(18),
                                                color: globals.isDark ? Colors.white : Colors.black54
                                            ),
                                          ),
                                          flex: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            (streamSnapshot.data.docs[index]['response_threads'].length-1)
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(18),
                                              color: globals.isDark ? Colors.white : Colors.black54,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>
                                                    TranslateScreen(
                                                      ownThread: false,
                                                      date: streamSnapshot.data
                                                          .docs[index]['timestamp'].toString(),
                                                      postedBy: streamSnapshot.data
                                                          .docs[index]['postedBy'].toString(),
                                                      responses: streamSnapshot.data
                                                          .docs[index]['responses'].toString(),
                                                      title: streamSnapshot.data
                                                          .docs[index]['title'].toString(),
                                                      uid: streamSnapshot.data.docs[index].id,
                                                      index: index,
                                                      threads: streamSnapshot
                                                          .data
                                                          .docs[index]['response_threads'],
                                                      format: streamSnapshot.data
                                                          .docs[index]['format'] == "mp4"
                                                          ? streamSnapshot.data
                                                          .docs[index]['download_url']
                                                          : null,
                                                    )
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward_rounded,
                                              color: globals.isDark ? Colors.white : Colors.black54,
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: globals.isDark ? Colors.white : Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5, right: 20),
                  child: Align(
                    child:  FlatButton(
                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllRequestsScreen(title: "All Requests")),
                        );
                      },
                      child: Text(
                        'View All Requests',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: globals.isDark ? Colors.white : Colors.black54
                        ),
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(bottom: 10,left: 30, right: 30),
                  child: InkWell(
                    child: Container(
                      width: ScreenUtil().setWidth(330),
                      height: ScreenUtil().setHeight(40),
                      decoration: BoxDecoration(
                          color: Colors.red,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExistingSings()),
                            );

                          },
                          child: Center(
                            child: Text("Browse Existing Signs",
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
          ),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

 

}


