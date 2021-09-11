
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpinghand/utils/constant.dart';
import 'package:helpinghand/widgets/video_player/video_player.dart';
import 'package:video_player/video_player.dart';

class VidePlayerDialog extends StatelessWidget {

  final String url;

  VidePlayerDialog({this.url});

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
    return
        SingleChildScrollView(
          child: Container(
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
            child:  Wrap(
                children: [
                  VideoPlayerScreen(url: this.url),
                  Container(
                    child:               Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                          )
                      ),
                    ),
                    padding: EdgeInsets.only(top: 10),
                  ),

                ],
              ),

            ),





    );
  }

}
