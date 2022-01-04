part of 'pages.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key key}) : super(key: key);
  @override
  _MyAccountState createState() => _MyAccountState();
}
class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;
  CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child : StreamBuilder<QuerySnapshot>(
        stream: userCollection.snapshots(),
        builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text("Failed to load data!");
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return ActivityServices.loadings();
          }
          return Stack(
            children : snapshot.data.docs.map((DocumentSnapshot doc) {
              Users users;
              if (doc['uid'] == FirebaseAuth.instance.currentUser.uid) {
                users = Users(
                  doc['uid'],
                  doc['name'],
                  doc['phone'],
                  doc['email'],
                  doc['password'],
                  doc['createdAt'],
                  doc['updatedAt']
                );
              }
              return AccountView(users:users);
            }).toList(),
          );
        }
      )
    );
  }
}