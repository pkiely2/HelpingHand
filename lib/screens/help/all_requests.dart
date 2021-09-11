part of screens;

class AllRequestsScreen extends StatefulWidget{

  final bool owner;
  final String title;

  AllRequestsScreen({this.owner = false, this.title});

  @override
  _AllRequestsScreen createState() => _AllRequestsScreen();
}

class _AllRequestsScreen extends State<AllRequestsScreen>{

  var cr;
  List<Widget> widgets = [];

  @override
  initState(){
    super.initState();
    FireStore.readItems().forEach((element) {
      for(var index = 0; index < element.size; index++){
        setState(() {
          if (this.widget.owner) {
            if (element.docs[index]['postedBy'] == FirebaseAuth.instance.currentUser.displayName) {
              widgets.add(Container(
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
                            (element.docs[index]['response_threads']
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
                                          date: element.docs[index]['timestamp']
                                              .toString(),
                                          postedBy: element.docs[index]['postedBy']
                                              .toString(),
                                          responses: element.docs[index]['responses']
                                              .toString(),
                                          title: element.docs[index]['title']
                                              .toString(),
                                          uid: element.docs[index].id,
                                          index: index,
                                          threads: element.docs[index]['response_threads'],
                                          format: element.docs[index]['format'] ==
                                              "mp4"
                                              ? element.docs[index]['download_url']
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
                    Divider(
                      color: globals.isDark
                          ? Colors.white
                          : Colors
                          .black54,
                    ),
                  ],
                ),
              ));
            }
          } else {
            widgets.add(Container(
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
                          (element.docs[index]['response_threads']
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
                                        date: element.docs[index]['timestamp']
                                            .toString(),
                                        postedBy: element.docs[index]['postedBy']
                                            .toString(),
                                        responses: element.docs[index]['responses']
                                            .toString(),
                                        title: element.docs[index]['title']
                                            .toString(),
                                        uid: element.docs[index].id,
                                        index: index,
                                        threads: element.docs[index]['response_threads'],
                                        format: element.docs[index]['format'] ==
                                            "mp4"
                                            ? element.docs[index]['download_url']
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
                  Divider(
                    color: globals.isDark
                        ? Colors.white
                        : Colors
                        .black54,
                  ),
                ],
              ),
            ));
          }
        }
        );
      }
      setState(() {
        cr = ListView(
          children: widgets,
        );
      });
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: !globals.isDark ? null : Colors.grey.shade900,
        ),
        padding: EdgeInsets.only(top: 40),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
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
                  padding: EdgeInsets.only(left: 70, top: 10),
                  child: Text(
                    this.widget.title,
                    style: TextStyle(
                      color: globals.isDark ? Colors.white : Colors.black54,
                      fontFamily: "Poppins-Bold",
                      fontSize: 20,
                      letterSpacing: 1.0),
                  ),
                ),


              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Title",
                          style: TextStyle(
                            fontSize: 18,
                            color: globals.isDark ? Colors.white : Colors.black54,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            "Responses",
                            style: TextStyle(
                              fontSize: 18,
                              color: globals.isDark ? Colors.white : Colors.black54,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Divider(
                    color: globals.isDark ? Colors.white : Colors.black54,
                    thickness: 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: cr,
            ),
            ),
          ],
        ),
      ),
    );
  }

}