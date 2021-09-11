part of screens;

class TranslateScreen extends StatefulWidget{

  final String title;
  final String date;
  final String postedBy;
  final String responses;
  final String uid;
  final String format;
  final bool ownThread;
  final List<dynamic> threads;
  final int index;

  TranslateScreen({this.title, this.ownThread, this.postedBy, this.date, this.responses, this.uid, this.threads, this.index, this.format});

  @override
  _TranslateScreen createState() => _TranslateScreen();
}

class _TranslateScreen extends State<TranslateScreen>{

  TextEditingController transalteController;
  bool passValidateText = false;

  @override
  void dispose() {
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
      body: Container(
        decoration: BoxDecoration(
          color: !globals.isDark ? null : Colors.grey.shade900,
        ),
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        height:  MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              this.widget.format == null ? "Text posted for Sign translation:" : "Video of Sign for translation:",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 5),
                          ),
                        ),
                        if(this.widget.format == null)
                          const SizedBox(height: 10.0),
                        if(this.widget.format == null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                this.widget.title,
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                              padding: EdgeInsets.only(left: 20),
                            ),
                          ),
                        if(this.widget.format != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: TextButton(
                                child: Text(
                                  "Click To Play Video",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return VidePlayerDialog(url: this.widget.format);
                                    },
                                  );
                                },
                              ),
                              padding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "Date Posted",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 5),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.parse(this.widget.date)),
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            padding: EdgeInsets.only(left: 20),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        if(this.widget.ownThread)
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    "Posted By",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 20),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        this.widget.postedBy,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                      padding: EdgeInsets.only(left: 20),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 20),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Align(
                child: Container(
                  child: Text(
                    "Responses",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 5),
                ),
                alignment: Alignment.centerLeft,
              ),
              Divider(
                thickness: 2,
                color: globals.isDark ? Colors.white : Colors.black54,
              ),
              Container(
                height:  MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height/1.9),
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
                        itemCount: 1,
                        itemBuilder: (ctx, index) => conv(streamSnapshot.data.docs[this.widget.index].id, streamSnapshot.data.docs[this.widget.index]['response_threads']),
                      );
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        iconSize: 30,
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Camera(reply: true, docId: this.widget.uid, postedBy: FirebaseAuth.instance.currentUser.displayName, threads: this.widget.threads),
                            ),
                          );
                        },
                      ),
                      padding: EdgeInsets.only(top: ScreenUtil().setSp(15)),
                    ),

                    Container(
                      child: TextFormField(
                        controller: transalteController,
                        decoration: InputDecoration(
                          hintText: "Send Reply",
                          counterStyle: TextStyle(color: globals.isDark ? Colors.white : Colors.black54),
                          suffixStyle: TextStyle(color: globals.isDark ? Colors.white : Colors.black54),
                          errorText: passValidateText ? 'Request Text Can\'t Be Empty' : null,
                          hintStyle: TextStyle(color: globals.isDark ? Colors.white : Colors.black54, fontSize: 15.0),
                          errorStyle: TextStyle(color: Colors.red, fontSize: 15.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if(transalteController.text == ""){
                                setState(() {
                                  passValidateText = !passValidateText;
                                });
                              }else{
                                setState(() {
                                  passValidateText = !passValidateText;
                                });

                                if(FirebaseAuth.instance.currentUser.displayName != null && FirebaseAuth.instance.currentUser.displayName.isNotEmpty){

                                  if(this.transalteController.text.isEmpty){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return new CustomDialogBoxState(title: 'Response Can\'t Be Empty',description: "Your response cannot be empty, please make sure you fill in the response box before replying");
                                        });
                                  }else {

                                    FireStore.updateThread(
                                        text: this.transalteController.text,
                                        postedBy: this.widget.postedBy,
                                        docId: this.widget.uid,
                                        threads: this.widget.threads,
                                        video: false
                                    )
                                        .whenComplete(() =>
                                    {
                                      Fluttertoast.showToast(
                                          msg: "Sent",
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blueAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      )
                                    })
                                        .onError((error, stackTrace) => null);
                                  }

                                  transalteController.text = "";

                                }else{
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return new CustomDialogBoxState(title: 'User Name Not Set',description: "You have to set you're username name in settings before being able to post or respond to requests");
                                      });
                                }


                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              color: globals.isDark ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(ScreenUtil().setSp(10)),
                      width: MediaQuery.of(context).size.width-80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
            this.widget.title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget conv(String docId, List<dynamic> list){

    List<Widget> widgets = [];

    for(var i = 0; i < list.length; i++){
      widgets.add(
        DateChip(
          date:  DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(list[i]["timestamp"].toString()))),
          color: Color(0x558AD3D5),
        ),
      );
      widgets.add(
        HoldTimeoutDetector(
          onTimeout: () {
            if(list[i]["approved"]){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return new ApprovedTranslation(translation: list[i]["text"], userName: list[i]["approval"]["approvedBy"], timeStamp: list[i]["approval"]["timestamp"]);
                  }
              );
            }else{
              if(i > 1) {
                if (FirebaseAuth.instance.currentUser.displayName != null &&
                    FirebaseAuth.instance.currentUser.displayName.isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return new ApproveTranslation(
                            url: false,
                            translation: list[i]["text"],
                            index: i,
                            threads: list,
                            docId: docId);
                      }
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return new CustomDialogBoxState(
                            title: 'User Name Not Set',
                            description: "You have to set you're username name in settings before being able to post or respond to requests");
                      });
                }
              }
            }
          },
          onTimerInitiated: () {},
          holdTimeout: Duration(milliseconds: 200),
          enableHapticFeedback: true,
          child: list[i]["text"] != null ? BubbleSpecialOne(
            text: list[i]["text"],
            isSender: FirebaseAuth.instance.currentUser.displayName != list[i]['postedBy'],
            color: list[i]["approved"] != null ? (list[i]["approved"] ? Colors.green : FirebaseAuth.instance.currentUser.displayName == this.widget.postedBy ? Colors.black12 : Colors.blueAccent) : FirebaseAuth.instance.currentUser.displayName == this.widget.postedBy ? Colors.black12 : Colors.blueAccent,
            textStyle: TextStyle(
              fontSize: 20,
              color: globals.isDark ? Colors.white : Colors.black54,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ) : BubbleVideoPlayer(
            url: list[i]['url'],
            isSender: FirebaseAuth.instance.currentUser.displayName != list[i]['postedBy'],
            color: list[i]["approved"] != null ? (list[i]["approved"] ? Colors.green : FirebaseAuth.instance.currentUser.displayName == this.widget.postedBy ? Colors.black12 : Colors.blueAccent) : FirebaseAuth.instance.currentUser.displayName == this.widget.postedBy ? Colors.black12 : Colors.blueAccent,
            textStyle: TextStyle(
              fontSize: 20,
              color: globals.isDark ? Colors.white : Colors.black54,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
            approved: list[i]["approved"],
            docId: docId,
            thrd: list,
            approvedBy: list[i]["approved"] ? list[i]["approval"]["approvedBy"] : null,
            timeStamp: list[i]["approved"] ? list[i]["approval"]["timestamp"] : null,
            threads: list,
            index: i,
          ),
        ),

      );

    }

    return Column(children: widgets);

  }

  String trimTittle(String title){
    List<String> split = title.split("");
    String spt = "";
    if(split.length > 3){
      spt = split[0] + " " + split[1] + " " + split[2] + " ...";
    }
    return spt.isEmpty ? title : spt;
  }
}

const double BUBBLE_RADIUS = 16;

class BubbleVideoPlayer extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool approved;
  final String text;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final int index;
  final TextStyle textStyle;
  final String url;
  final String docId;
  final String approvedBy;
  final String timeStamp;
  final dynamic thrd;
  final dynamic threads;

  BubbleVideoPlayer({
    Key key,
    this.text,
    this.bubbleRadius = BUBBLE_RADIUS,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.url,
    this.threads,
    this.index,
    this.timeStamp,
    this.approvedBy,
    this.thrd,
    this.docId,
    this.approved = false,
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
                  Stack(
                    children: <Widget>[
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
                  Container(
                    padding: EdgeInsets.all(10),
                    child: VideoPlayerScreen(url: this.url),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: approved ? Text('Approved Info') : Text('Approve'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                      onPressed: (){

                        if(approved){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return new ApprovedTranslation(userName: approvedBy, timeStamp: timeStamp);
                              }
                          );
                        }else{
                            if (FirebaseAuth.instance.currentUser.displayName != null &&
                                FirebaseAuth.instance.currentUser.displayName.isNotEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return new ApproveTranslation(
                                        translation: url,
                                        index: index,
                                        threads: threads,
                                        docId: docId);
                                  }
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return new CustomDialogBoxState(
                                        title: 'User Name Not Set',
                                        description: "You have to set you're username name in settings before being able to post or respond to requests");
                                  });

                          }
                        }
                      },
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