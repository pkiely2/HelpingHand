part of screens;

class RecentActivity extends StatefulWidget{

  @override
  _RecentActivity createState() => _RecentActivity();
}

class _RecentActivity extends State<RecentActivity>{
  TextEditingController transalteController;
  bool passValidateText = false;
  List<Widget> list = [];
  var cr;

  @override
  void dispose() {
    transalteController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FireStore.readItems().forEach((element) {
      for(var index = 0; index < element.size; index++){
          setState(() {
            if(element.docs[index]['postedBy'] == FirebaseAuth.instance.currentUser.displayName){
              if(element.docs[index]['format'] == "mp4"){
                list.add(CustomBubble(
                  text: "Posted A New Request",
                  isSender: true,
                  color: Colors.blue,
                  index: index,
                  threads: element,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: globals.isDark ? Colors.white : Colors.black54,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }else {
                list.add(CustomBubble(
                  text: "Posted A New Request",
                  isSender: false,
                  color: Colors.black12,
                  index: index,
                  threads: element,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: globals.isDark ? Colors.white : Colors.black54,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }
            }else{
              for(var i = 1; i < element.docs[index]['response_threads'].length; i++){
                if(element.docs[index]['response_threads'][i]["postedBy"] == FirebaseAuth.instance.currentUser.displayName){
                  list.add(CustomBubble(
                    text: "Replied To A Request",
                    isSender: true,
                    index: index,
                    threads: element,
                    color: Colors.blueAccent,
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: globals.isDark ? Colors.white : Colors.black54,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
                }
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
    return Scaffold(
      appBar: AppBar(
        title: Text("My Recent Activity"),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: !globals.isDark ? null : Colors.grey.shade900,
        ),
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        height:  MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: cr,
      ),
    );
  }


}


class CustomBubble extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final String text;
  final String timeStamp;
  final String sender;
  final QuerySnapshot threads;
  final int index;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;

  CustomBubble({
    Key key,
    this.text,
    this.bubbleRadius = BUBBLE_RADIUS,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.index,
    this.seen = false,
    this.sender = "",
    this.timeStamp,
    this.threads,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    return Row(
      children: <Widget>[
        isSender
            ? Expanded(
          child: SizedBox(
            width: 5,
          ),
        )
            : Container(),
        Container(
          color: Colors.transparent,
          constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bubbleRadius),
                  topRight: Radius.circular(bubbleRadius),
                  bottomLeft: Radius.circular(tail
                      ? isSender
                      ? bubbleRadius
                      : 0
                      : BUBBLE_RADIUS),
                  bottomRight: Radius.circular(tail
                      ? isSender
                      ? 0
                      : bubbleRadius
                      : BUBBLE_RADIUS),
                ),
              ),
              child: Column(
                children: [
                  if(this.sender != null &&  this.sender.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 12),
                      child: Text(
                        this.sender,
                        style: textStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      if(this.sender.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                            child: Padding(
                            padding: stateTick
                                ? EdgeInsets.fromLTRB(12, 10, 28, 6)
                                : EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 16,
                                color: this.isSender ? Colors.white : (globals
                                    .isDark ? Colors.white : Colors.black54),
                              ),
                              textAlign: TextAlign.left,
                            ),
                        ),
                      ),
                      stateIcon != null && stateTick
                          ? Positioned(
                        bottom: 4,
                        right: 6,
                        child: stateIcon,
                      )
                          : SizedBox(
                        width: 1,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: stateTick
                            ? EdgeInsets.fromLTRB(12, 6, 28, 6)
                            : EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              "Title: ",
                              style: textStyle,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              threads.docs[index]['title'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: this.isSender ? Colors.white : (globals
                                    .isDark ? Colors.white : Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              TranslateScreen(
                                ownThread: false,
                                date: threads
                                    .docs[index]['timestamp'].toString(),
                                postedBy: threads
                                    .docs[index]['postedBy'].toString(),
                                responses: threads
                                    .docs[index]['responses'].toString(),
                                title: threads
                                    .docs[index]['title'].toString(),
                                uid: threads.docs[index].id,
                                index: index,
                                threads: threads
                                    .docs[index]['response_threads'],
                                format: threads
                                    .docs[index]['format'] == "mp4"
                                    ? threads
                                    .docs[index]['download_url']
                                    : null,
                              )
                          ),
                        );
                      },
                      child: Text(
                        "View Thread",
                        style: TextStyle(color: this.isSender ? Colors.white :  (globals
                            .isDark ? Colors.white : Colors.black54)),
                      ),

                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10),
                      child: Text(
                        DateFormat('yyyy-MM-dd – HH:mm:ss').format(DateTime.parse(threads.docs[index]['timestamp'])).toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: this.isSender ? Colors.white : (globals
                                .isDark ? Colors.white : Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}