part of dialogs;

class ConnectionStateDialog extends StatelessWidget {

  ConnectionStateDialog();

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
              Text("No Internet Connection", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Icon(Icons.wifi_off_outlined, size: 50),
              SizedBox(height: 10,),
              Text("Connect to the internet to continue using Helping Hand",style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
            ],
          ),
        ),
      ],
    );
  }
}
