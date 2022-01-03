part of 'pages.dart';

class PendingRequest extends StatefulWidget {
  static const String routeName = "/pendingrequest";

  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference pendingCollection = FirebaseFirestore.instance.collection("Pending");

  Widget buildBody(){
    return Container(
        width: double.infinity,
        height: double.infinity,
        //mendeteksi perubahan data secara otomatis
        child : StreamBuilder<QuerySnapshot>(
          stream: pendingCollection.snapshots(),
          builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text("Failed to load data!");
            }
            if (snapshot.connectionState == ConnectionState.waiting){
              return ActivityServices.loadings();
            }
            return ListView(
              children : snapshot.data.docs.map((DocumentSnapshot doc){
                //  Map<String, dynamic> doc = docs as Map<String, dynamic>;
                Pending pending;
                if (doc['addBy'] == FirebaseAuth.instance.currentUser.uid) {
                 // ActivityServices.showToast("gagal ehe"+doc['pendingId'], Colors.green);
                  pending = Pending(
                    doc['pendingId'],
                    doc['templateName'],
                    doc['link'],
                    doc['color'],
                    doc['description'],
                    doc['status'],
                    doc['addBy']
                );
                }else{
                  ActivityServices.showToast("gagal ehe"+doc['templateName'], Colors.red);
                  pending = null;
                 }
                return PendingView(pending:pending);
              }).toList(),
            );
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildBody(),
    );
  }
}
