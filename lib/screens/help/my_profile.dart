part of screens;

class Profile extends StatefulWidget {

  @override
  _ProfileScreen createState() => _ProfileScreen();

}

class _ProfileScreen extends State<Profile>{

  List<Widget> list = [];
  var cr;

  @override
  void initState() {
    super.initState();
    FireStore.readItems().forEach((element) {
      for(var index = 0; index < element.size; index++){
        setState(() {
          for(var i = 0; i < element.docs[index]["response_threads"].length; i++){
            if(element.docs[index]["response_threads"][i]["postedBy"] == FirebaseAuth.instance.currentUser.displayName){
              list.add(Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            element.docs[index]['title'],
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              color: globals.isDark
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                          flex: 8,
                        ),
                        Expanded(
                          child: Text(
                            (element.
                                docs[index]['response_threads']
                                .length - 1)
                                .toString(),
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              color: globals.isDark
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TranslateScreen(
                                          ownThread: false,
                                          date: element.
                                              docs[index]['timestamp']
                                              .toString(),
                                          postedBy: element.
                                              docs[index]['postedBy']
                                              .toString(),
                                          responses: element.
                                              docs[index]['responses']
                                              .toString(),
                                          title: element.
                                              docs[index]['title']
                                              .toString(),
                                          uid: element
                                              .docs[index].id,
                                          index: index,
                                          threads: element
                                              .docs[index]['response_threads'],
                                          format: element
                                              .docs[index]['format'] ==
                                              "mp4"
                                              ? element
                                              .docs[index]['download_url']
                                              : null,
                                        )
                                ),
                              );
                            },
                            color: globals.isDark
                                ? Colors.white
                                : Colors.black54,
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              color: globals.isDark
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ));
              break;
            }
          }
        });
      }
      setState(() {
        cr = ListView(children: list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
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
              Container(
                  padding: EdgeInsets.only(left: 20, right: 30),
                  child: Column(
                    children: [
                      Align(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "My Requests",
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
                              color: globals.isDark ? Colors.white : Colors.black54,
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
                height: 180,
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
                                    if(streamSnapshot.data
                                        .docs[index]['postedBy'].toString() ==
                                        FirebaseAuth.instance.currentUser
                                            .displayName)
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  streamSnapshot.data
                                                      .docs[index]['title'],
                                                  style: TextStyle(
                                                      color: globals.isDark
                                                          ? Colors
                                                          .white
                                                          : Colors.black54,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18)),
                                                ),
                                                flex: 8,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  streamSnapshot.data
                                                      .docs[index]['responses']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: globals.isDark
                                                          ? Colors
                                                          .white
                                                          : Colors.black54,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18)),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TranslateScreen(
                                                                ownThread: false,
                                                                date: streamSnapshot
                                                                    .data
                                                                    .docs[index]['timestamp']
                                                                    .toString(),
                                                                postedBy: streamSnapshot
                                                                    .data
                                                                    .docs[index]['postedBy']
                                                                    .toString(),
                                                                responses: (streamSnapshot.data
                                                                    .docs[index]['response_threads'].length-1)
                                                                    .toString(),
                                                                title: streamSnapshot
                                                                    .data
                                                                    .docs[index]['title']
                                                                    .toString(),
                                                                uid: streamSnapshot
                                                                    .data
                                                                    .docs[index]
                                                                    .id,
                                                                index: index,
                                                                threads: streamSnapshot
                                                                    .data
                                                                    .docs[index]['response_threads'],
                                                                format: streamSnapshot
                                                                    .data
                                                                    .docs[index]['format'] ==
                                                                    "mp4"
                                                                    ? streamSnapshot
                                                                    .data
                                                                    .docs[index]['download_url']
                                                                    : null,
                                                              )
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_forward_rounded,
                                                    color: globals.isDark
                                                        ? Colors.white
                                                        : Colors.black54,
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                        ],
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
                        MaterialPageRoute(builder: (context) => AllRequestsScreen(owner: true, title: "All My Requests")),
                      );
                    },
                    child: Text(
                      'View All My Requests',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: globals.isDark ? Colors.white : Colors.black54,
                      ),
                    ),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20, right: 30, top: 20),
                  child: Column(
                    children: [
                      Align(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "My Response",
                            style: TextStyle(
                              fontSize: 18,
                              color: globals.isDark ? Colors.white : Colors.black54,
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
                              color: globals.isDark ? Colors.white : Colors.black54,
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
                child: cr,
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
                        MaterialPageRoute(builder: (context) => AllRequestsScreen(owner: true, title: "All My Responses")),
                      );
                    },
                    child: Text(
                      'View All My Responses',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: globals.isDark ? Colors.white : Colors.black54,
                      ),
                    ),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 40,left: 30, right: 30),
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
                            MaterialPageRoute(builder: (context) =>
                                RecentActivity()
                            ),
                          );

                        },
                        child: Center(
                          child: Text("View My Recent Activity",
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
      ),
    );
  }


}