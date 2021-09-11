part of screens;

class Community extends StatefulWidget{

  @override
  _Community createState() => _Community();
}

class _Community extends State<Community>{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
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
              decoration: BoxDecoration(
                color: !globals.isDark ? null : Colors.grey.shade900,
              ),
              padding: EdgeInsets.only(left: 15, right: 15),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                    } else {
                      return ListView.builder(
                          padding: EdgeInsets.only(bottom: 200),
                          itemCount: streamSnapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(height: 15),
                                CustomBubble(
                                  text: streamSnapshot.data.docs[index]['format']
                                      .toString() == "mp4"
                                      ? "Posted A New Video Request"
                                      : "Posted A New Text Request",
                                  isSender: streamSnapshot.data.docs[index]['format']
                                      .toString() == "mp4",
                                  color: streamSnapshot.data.docs[index]['format']
                                      .toString() == "mp4" ? Colors.blue : Colors
                                      .grey,
                                  index: index,
                                  sender: streamSnapshot.data.docs[index]['postedBy']
                                      .toString(),
                                  threads: streamSnapshot.data,
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: streamSnapshot.data.docs[index]['format']
                                        .toString() == "mp4" ? Colors.white : (globals
                                        .isDark ? Colors.white : Colors.black54),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          }
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

}
