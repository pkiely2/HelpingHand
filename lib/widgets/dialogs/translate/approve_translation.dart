part of dialogs;

class ApproveTranslation extends StatefulWidget {

  final bool url;
  final String translation;
  final int index;
  final String docId;
  final List<dynamic> threads;

  ApproveTranslation({this.url = true, this.threads, this.translation, this.index, this.docId});

  @override
  _ApproveTranslation createState() => _ApproveTranslation();
}

class _ApproveTranslation extends State<ApproveTranslation>{

  @override
  void initState() {
    super.initState();
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
              Text("Approve Translation",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600)),
              SizedBox(height: 15,),
              if(!this.widget.url)
              Text(this.widget.translation + " will me marked as approved and will be viewable to other users", style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              Text("Video will me marked as approved and will be viewable to other users", style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        onPressed: (){
                          Navigator.pop(context, true);

                        },
                        child: Text("Cancel",style: TextStyle(fontSize: 18))
                    ),
                    FlatButton(
                        onPressed: (){
                          this.widget.threads[this.widget.index]["approved"] = true;
                          this.widget.threads[this.widget.index]["approval"] = {
                            "approvedBy" : FirebaseAuth.instance.currentUser.displayName,
                            "timestamp" :  DateTime.now().toString(),
                          };
                          FireStore.updateThreadApproved(this.widget.docId, this.widget.threads).whenComplete(() => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new CustomDialogBoxState(title: 'Translation Approved',description: "Translation has been successfully approved");
                                }),
                          });
                          Navigator.pop(context, true);
                        },
                        child: Text("Approve",style: TextStyle(fontSize: 18, color: Colors.green))
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }





}
