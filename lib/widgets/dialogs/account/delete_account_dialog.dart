part of dialogs;

class DeleteAccountDialog extends StatelessWidget {

  DeleteAccountDialog ();

  final TextEditingController textEditingController = new TextEditingController();

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
              const Text("Delete Account", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600, color: Colors.red)),
              SizedBox(height: 15,),
              const Text("Are You Sure You Want To Delete Your Account",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              SizedBox(
                width: 275,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Password',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text('Close',style: TextStyle(fontSize: 18),)
                  ),
                  FlatButton(
                        onPressed: (){

                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                        )
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }
}
