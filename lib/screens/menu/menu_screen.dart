part of screens;
class MenuScreen extends StatefulWidget {
  final List<MenuItem> mainMenu;
  final Function(int) callback;
  final int current;

  MenuScreen(
      this.mainMenu, {
        Key key,
        this.callback,
        this.current,
      });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String userName = "Name";
  String photoUrl = "";
  final widthBox = SizedBox(
    width: 16.0,
  );

  @override
  initState(){
    User currentUser = FirebaseAuth.instance.currentUser;

    super.initState();
    setState((){
      if(currentUser != null) {
        if(currentUser.displayName != null) {
          if (currentUser.displayName.contains(" ")) {
            userName = currentUser.displayName.replaceAll(" ", "\n");
          } else {
            userName = currentUser.displayName;
          }
        }
        if (currentUser.photoURL != null) {
          photoUrl = currentUser.photoURL;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle androidStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
    final TextStyle iosStyle = const TextStyle(color: Colors.white);
    final style = kIsWeb
        ? androidStyle
        : Platform.isAndroid
        ? androidStyle
        : iosStyle;

    return Material(
      child: Container(
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0, right: 34.0),
                    child: Container(
                      child: AvatarImage(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 24.0),
                    child: Text(
                      userName.isEmpty ? "Update Username\nIn Settings" : userName,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Selector<MenuProvider, int>(
                      selector: (_, provider) => provider.currentPage,
                      builder: (_, index, __) => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ...widget.mainMenu
                              .map((item) => MenuItemWidget(
                            key: Key(item.index.toString()),
                            item: item,
                            callback: widget.callback,
                            widthBox: widthBox,
                            style: style,
                            selected: index == item.index,
                          ))
                              .toList()
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 5.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Text("Log Out"),
                      onPressed: () {
                        Authentication.signOut(context: context);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
        ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;
  final Widget widthBox;
  final TextStyle style;
  final Function callback;
  final bool selected;

  final white = Colors.white;

  const MenuItemWidget({
    Key key,
    this.item,
    this.widthBox,
    this.style,
    this.callback,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback(item.index),
      style: TextButton.styleFrom(
        primary: selected ? Color(0x44000000) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item.icon,
            color: white,
            size: 24,
          ),
          widthBox,
          Expanded(
            child: Text(
              item.title,
              style: style,
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final int index;

  const MenuItem(this.title, this.icon, this.index);
}
