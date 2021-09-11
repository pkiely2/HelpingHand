part of screens;


class ProfileScreen extends StatefulWidget {

  static List<MenuItem> mainMenu = [
    MenuItem("My Activity", Icons.person_outline_sharp, 0),
    MenuItem("Community", Icons.message, 1),
    MenuItem("Get/Give Help", Icons.add_box, 2),
    MenuItem("Info", Icons.help, 3),
    MenuItem("Settings", Icons.info_outline, 4),
  ];

  ProfileScreen({Key key, User user}) : super(key: key);
  
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfileScreen> {

  final _drawerController = ZoomDrawerController();
  StreamSubscription<DataConnectionStatus> listener;
  ConnectionStateDialog customDialogBoxState;
  int _currentPage = 0;
  bool connected = false;

  @override
  void initState() {
    super.initState();
    customDialogBoxState = ConnectionStateDialog();

    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        case DataConnectionStatus.connected:
          if(connected){
            Navigator.pop(context);
            setState(() {
              connected = false;
            });
          }
          break;
        case DataConnectionStatus.disconnected:
          _showDialog();
          setState(() {
            connected = true;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    listener?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: _drawerController,
        style: DrawerStyle.Style4,
        menuScreen: MenuScreen(
          ProfileScreen.mainMenu,
          callback: _updatePage,
          current: _currentPage,
        ),
        mainScreen: MainScreen(_drawerController),
        borderRadius: 24.0,
        showShadow: false,
        angle: 0.0,
        backgroundColor: Colors.grey[300],
        slideWidth: MediaQuery.of(context).size.width*(0.65),

    );

  }

  void _updatePage(index) {
    Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index);
    _drawerController.toggle();
  }

  _showDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return customDialogBoxState;
        });
  }

}

class MainScreen extends StatefulWidget {
  final ZoomDrawerController ctrl;

  MainScreen(this.ctrl);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: ValueListenableBuilder<DrawerState>(
          valueListenable: ZoomDrawer.of(context).stateNotifier,
          builder: (context, state, child) {
            return AbsorbPointer(
              absorbing: state != DrawerState.closed,
              child: child,
            );
          },
          child: GestureDetector(
            child: PageStructure(),
            onPanUpdate: (details) {
              if (details.delta.dx < 6) {
                ZoomDrawer.of(context).toggle();
              }
            },
          ),
        ),
      );
  }
}

class MenuProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updateCurrentPage(int index) {
    if (index != currentPage) {
      _currentPage = index;
      notifyListeners();
    }
  }
}


