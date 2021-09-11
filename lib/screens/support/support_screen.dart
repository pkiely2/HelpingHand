part of screens;

class SupportScreen extends StatefulWidget{
  @override
  _SupportScreen createState() => _SupportScreen();
}

class _SupportScreen extends State<SupportScreen>{

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
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: !globals.isDark ? null : Colors.grey.shade900,
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: this.controller,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
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
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'How Does Helping Hand Work',
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
                      "Helping Hand is a free community platform which allows users to upload text or videos to get a ISL<->English translation. Users can also respond to pending requests. Accurate translations can be approved by all users.",
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
                        'How Can Users Post A Request',
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
                      "On the Get/Give Help screen, users can either post a text request which would receive a video response by another users or vice-versa",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: globals.isDark ? Colors.white : Colors.black54,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'How Are Translations Approved',
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
                      "If a user deems that a translation is accurate, they can approve the translation by pressing and holding the translation and pressing approve on the popup dialog. Once approved, it is shown in green and the date and user who approved is available.",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: globals.isDark ? Colors.white : Colors.black54,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSupport()));
                            },
                            child:  ProfileListItem(
                              icon: Icons.account_circle_outlined,
                              text: 'Account Support',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}