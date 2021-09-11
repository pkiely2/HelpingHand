part of dialogs;

class CustomDialogBoxState extends StatelessWidget {

  final String title;
  final String description;
  final VoidCallback voidCallback;

  CustomDialogBoxState({this.title, this.description, this.voidCallback});

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
              Text(this.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(this.description,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                        Navigator.pop(context, true);
                    },
                    child: Text("Ok",style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
