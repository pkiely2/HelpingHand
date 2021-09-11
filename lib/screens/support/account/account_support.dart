part of screens;

class AccountSupport extends StatefulWidget{

  @override
  _AccountSupport createState() => _AccountSupport();
}

class _AccountSupport extends State<AccountSupport>{
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: !globals.isDark ? null : Colors.grey.shade900,
          ),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 30, left: 5),
                  child:  IconButton(
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
              SingleChildScrollView(
                controller: this.controller,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child:Text(
                        'How do I reset my password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          color: globals.isDark ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'To change your password go to Settings -> Password & Security and click Send Password Reset Email. An email will be sent to your registered email with the instructions on how to reset your password',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: globals.isDark ? Colors.white : Colors.black54,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'How do I change my Display Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          color: globals.isDark ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'To change your display name go to Settings and then press the pen icon next to your username.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: globals.isDark ? Colors.white : Colors.black54,
                          fontSize: 15
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

}