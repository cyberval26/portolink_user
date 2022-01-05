part of "widgets.dart";

class AccountView extends StatefulWidget {
  const AccountView({Key key, this.users}) : super(key: key);
  static const String routeName = "/accountview";
  final Users users;
  @override
  _AccountViewState createState() => _AccountViewState();
}
class _AccountViewState extends State<AccountView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Users users = widget.users;
    if (users == null) {
      return Container();
    }
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              Image.asset("assets/images/portolink.png", height: 300),
              ElevatedButton.icon(
                icon: const Icon(CupertinoIcons.pencil),
                label: const Text("Edit Data"),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => UpdateAccount(
                      id: users.uid,
                      name: users.name,
                      phone: users.phone,
                    )
                  ));
                }
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.black54),
                  Text(
                    "  " + users.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24)
                  )
                ]
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, color: Colors.black54),
                  Text(
                    "  " + users.phone,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  )
                ]
              )
            ]
          )
        ),
        Align(
          alignment: const AlignmentDirectional(0, 0.7),
          child: ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await AuthServices.signOut().then((value) {
                if (value == true) {
                  setState(() {
                    isLoading = false;
                  });
                  ActivityServices.showToast("Logout Success", Colors.grey);
                  Navigator.pushReplacementNamed(context, Login.routeName);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  ActivityServices.showToast("Logout Failed", Colors.red);
                }
              });
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout")
          )
        )
      ]
    );
  }
}