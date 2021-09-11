part of screens;

class ExistingSings extends StatefulWidget{

  @override
  _ExistingSigns createState() => _ExistingSigns();

}

class _ExistingSigns extends State<ExistingSings>{

  var cr;
  List<dynamic> list = [];
  TextEditingController transalteController;
  bool passValidateText = false;
  int listView = 0;

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

  void filter() async{
    setState(() {
      list.clear();
    });
    FireStore.readItems().forEach((element) {
      for(var i = 0; i < element.size; i++){
        if(element.docs[i].get("title").toString().toLowerCase().contains(this.transalteController.text.toLowerCase())){
          setState(() {
            list.add(element.docs[i]);
          });
        }
      }
    });
    initCnt();
  }

  Container initCnt(){
    setState(() {
      cr = Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height - 300,
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            list[index]['title'],
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              color: globals.isDark ? Colors.white : Colors
                                  .black54,
                            ),
                          ),
                          flex: 8,
                        ),
                        Expanded(
                          child: Text(
                            (list[index]['response_threads'].length - 1)
                                .toString(),
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(18),
                                color: globals.isDark ? Colors.white : Colors
                                    .black54
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
                                      date: list[index]['timestamp']
                                          .toString(),
                                      postedBy: list[index]['postedBy']
                                          .toString(),
                                      responses: (list[index]['response_threads']
                                          .length - 1).toString(),
                                      title: list[index]['title'].toString(),
                                      uid: list[index].id,
                                      index: index,
                                      threads: list[index]['response_threads'],
                                    )
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              color: globals.isDark ? Colors.white : Colors
                                  .black54,
                            ),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    Divider(
                        color: globals.isDark ? Colors.white : Colors.black54),
                  ],
                ),
              );
            }
        ),
      );
    });
    return cr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 40, right: 25),
                  child:  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: IconTheme(
                        data: new IconThemeData(
                            color: globals.isDark ? Colors.white54 : Colors.grey.shade900),
                        child: new Icon(Icons.arrow_back_ios),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Container(
              decoration: BoxDecoration(
                color: !globals.isDark ? null : Colors.grey.shade900,
              ),
              padding: EdgeInsets.only(left: 25, right: 25),
              height:  MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [

                  Container(
                    child: TextFormField(
                      style: TextStyle(color: globals.isDark ? Colors.white : Colors.black54),
                      controller: transalteController,
                      decoration: InputDecoration(
                        hintText: "Enter Request Text Here",
                        hintStyle: TextStyle(color: globals.isDark ? Colors.white : Colors.black54, fontSize: 15.0),
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
                            }
                            filter();
                          },
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            color: globals.isDark ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(ScreenUtil().setSp(30)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 2),
                          child: Text("" , style: TextStyle(color: globals.isDark ? Colors.white : Colors.black54)),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 2),
                            child: Text("Best Matches", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: globals.isDark ? Colors.white : Colors.black54))
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 10),
                        child: Divider(
                            color: globals.isDark ? Colors.white : Colors.black54
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width/2)-20, right: 5),
                        child: Divider(
                          color: globals.isDark ? Colors.white : Colors.black54,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  initCnt(),
                ],
              ),

          ),
              ],
            ),
          ),
        ),
      );
  }


}