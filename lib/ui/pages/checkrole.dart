part of 'pages.dart';

/*class Checkrole extends StatefulWidget {
  static const String routeName = "/myaccount";

  @override
  _CheckroleState createState() => _CheckroleState();
}

class _CheckroleState extends State<Checkrole> {
  CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  //Users users;
  bool isLoading = false;

  Widget buildBody(){
    return Container(
        width: double.infinity,
        height: double.infinity,
        //mendeteksi perubahan data secara otomatis
        child : StreamBuilder<QuerySnapshot>(
          stream: userCollection.snapshots(),
          builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text("Failed to load data!");
            }
            if (snapshot.connectionState == ConnectionState.waiting){
              return ActivityServices.loadings();
            }

            return  Stack(
              children : snapshot.data.docs.map((DocumentSnapshot doc){
              //Map<String, dynamic> doc = docs as Map<String, dynamic>;
                Users users;
                if (doc['uid'] == FirebaseAuth.instance.currentUser.uid){
                  ActivityServices.showToast("gagal ehe"+FirebaseAuth.instance.currentUser.uid, Colors.green);
                  users = Users(
                    doc['uid'],
                    doc['name'],
                    doc['phone'],
                    doc['email'],
                    doc['password'],
                    doc['createdAt'],
                    doc['updatedAt'],
                  );
              } else {
                 ActivityServices.showToast("gagal ehe"+doc['uid'], Colors.red);
                 users = null;
              }
                return MainMenu(users:users);
              }).toList(),
            );
          },
        )
    );
  }

  /*doc['uid'],
  doc['name'],
  doc['phone'],
  doc['email'],
  doc['password'],
  doc['createdAt'],
  doc['updateAt'],*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() =>  Navigator.pushReplacementNamed(context, Dashboard.routeName),
        )
      ),
      body: buildBody(),
    );
  }
}*/
