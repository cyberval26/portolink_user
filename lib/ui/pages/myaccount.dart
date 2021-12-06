part of 'pages.dart';

class MyAccount extends StatefulWidget {


  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
              children : snapshot.data.docs.map((DocumentSnapshot docs){
                Map<String, dynamic> doc = docs as Map<String, dynamic>;
                Users users;
                if (doc['uid'] == FirebaseAuth.instance.currentUser.uid){
                  users =  Users(
                    doc['uid'],
                    doc['name'],
                    doc['phone'],
                    doc['email'],
                    doc['password'],
                    doc['createdAt'],
                    doc['updateAt'],
                  );
              } else {
                 ActivityServices.showToast("gagal ehe"+FirebaseAuth.instance.currentUser.email, Colors.red);
                  users = null;
               }
                return AccountView(users:users);
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
      ),
      body: buildBody(),
    );
  }
}
