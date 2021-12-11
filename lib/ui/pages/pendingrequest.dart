part of 'pages.dart';

class PendingRequest extends StatefulWidget {
  static const String routeName = "/pendingrequest";

  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  CollectionReference pendingCollection = FirebaseFirestore.instance.collection("pending");

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
               // if (doc['pendingId'] != null) {
                  ActivityServices.showToast("gagal ehe"+doc['pendingId'], Colors.green);
                  pending = Pending(
                    doc['pendingId'],
                    doc['templateName'],
                    doc['link'],
                    doc['description'],
                    doc['status'],
                );
                // }else{
                //  ActivityServices.showToast("gagal ehe"+doc['templatename'], Colors.red);
                //   pending = null;
                // }

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
      appBar: AppBar(
          title: Text("Pending Request"),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() =>  Navigator.pushReplacementNamed(context, Dashboard.routeName),
          )
        // centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody(),
    );
  }
}
