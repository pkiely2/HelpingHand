part of screens;


class PageStructure extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> actions;
  final Color backgroundColor;
  final double elevation;

  const PageStructure({
    Key key,
    this.title,
    this.child,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  Widget cont(int _currentpage){
    switch(_currentpage){
      case 0: return Profile();
      case 1: return Community();
      case 2: return GetHelpScreen();
      case 3: return SupportScreen();
      case 4: return SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _currentPage = context.select<MenuProvider, int>((provider) => provider.currentPage);
    final container = Scaffold(
        body: cont(_currentPage),
    );



    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index),
        backgroundColor: Colors.grey.shade300,
        items: ProfileScreen.mainMenu
            .map(
              (item) => BottomNavigationBarItem(
            label: item.title,
            icon: Icon(
              item.icon,
              color: Colors.blue,
            ),
          ),
        )
            .toList(),
      ),
      body: kIsWeb
          ? container
          : Platform.isAndroid
          ? container
          : SafeArea(
        child: container,
      ),
    );
  }
}
