part of 'pages.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = "/mainmenu";
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions =  <Widget>[
    ListTemplate(),
    PendingRequest(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void InitState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
              label: "Pending Request",
            ),
        ],
        currentIndex: _selectedIndex,
          onTap: _onItemTapped,
      ) ,
    );
  }
}
