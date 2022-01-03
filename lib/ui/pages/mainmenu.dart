part of 'pages.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key key}) : super(key: key);
  static const String routeName = "/mainmenu";
  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> {
  bool isLoading = false;
  int _selectedIntex = 0;
  static List<Widget> _widgetOptions = <Widget>[
     ListTemplate(),
     PendingRequest(),
     OurCountact(),
     MyAccount()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIntex = index;
    });
  }
  @override
  void InitState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIntex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_rounded),
              label: "List template",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add_rounded),
              label: "Pending",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: "Our Contact",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
            ),
          ],
          currentIndex: _selectedIntex,
          onTap: _onItemTapped,
        ),
      );
    }
  }

