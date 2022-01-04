part of 'pages.dart';

class PendingRequest extends StatefulWidget {
  const PendingRequest({Key key}) : super(key: key);
  @override
  _PendingRequestState createState() => _PendingRequestState();
}
class _PendingRequestState extends State<PendingRequest> {
  CollectionReference pendingCollection = FirebaseFirestore.instance.collection("Pending");
  Widget buildBody(){
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child : StreamBuilder<QuerySnapshot>(
        stream: pendingCollection.snapshots(),
        builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError){
            return const Text("Failed to load data!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ActivityServices.loadings();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot doc) {
              Pending pending;
              if (doc['addBy'] == FirebaseAuth.instance.currentUser.uid) {
                pending = Pending(
                  doc['pendingId'],
                  doc['templateName'],
                  doc['link'],
                  doc['color'],
                  doc['description'],
                  doc['status'],
                  doc['addBy']
                );
              }
              return PendingView(pending:pending);
            }).toList()
          );
        }
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