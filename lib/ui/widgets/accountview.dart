part of "widgets.dart";

class AccountView extends StatefulWidget {
  const AccountView({Key key, this.users}) : super(key: key);
  static const String routeName = "/accountview";
  final Users users;
  @override
  _AccountViewState createState() => _AccountViewState();
}
_prefixIcon(IconData iconData) {
  return ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
    child: Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue[100].withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(10.0)
        )
      ),
      child: Icon(
        iconData,
        size: 20,
        color: Colors.blue,
      )
    )
  );
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateAccount(
                        id: users.uid,
                        name: users.name,
                        phone: users.phone
                      )
                    )
                  );
                }
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _prefixIcon(Icons.email),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Name', style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: Colors.black
                        )
                      ),
                      const SizedBox(height: 1),
                      Text(users.name)
                    ]
                  )
                ]
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _prefixIcon(Icons.phone),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Phone', style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: Colors.black
                        )
                      ),
                      const SizedBox(height: 1),
                      Text(users.phone)
                    ]
                  )
                ]
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _prefixIcon(Icons.email),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: Colors.black
                        )
                      ),
                      const SizedBox(height: 1),
                      Text(users.email)
                    ]
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