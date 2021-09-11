part of dialogs;

class ApprovedTranslation extends StatefulWidget {

  final String translation;
  final String userName;
  final String timeStamp;

  ApprovedTranslation({this.translation, this.timeStamp, this.userName});

  @override
  _ApprovedTranslation createState() => _ApprovedTranslation();
}

class _ApprovedTranslation extends State<ApprovedTranslation>{

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
              Text("Translation Approved",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600)),
              SizedBox(height: 15),
              if(this.widget.translation != null)
              Text(this.widget.translation, style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Approved By : ", style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                  Text(nameFormat(this.widget.userName), style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Approval Date : ", style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
                  Text(DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.parse(this.widget.timeStamp)), style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
                ],
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.pop(context, true);

                    },
                    child: Text("Ok",style: TextStyle(fontSize: 18))
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  String nameFormat(String name){
    return name.contains(" ") ? name.replaceAll(" ","\n") : name;
  }


}
