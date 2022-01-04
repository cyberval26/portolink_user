
part of 'pages.dart';


class ListTemplate extends StatefulWidget {
  const ListTemplate({Key key}) : super(key: key);
  static const String routeName = "/listemplate";
  @override
  _ListTemplateState createState() => _ListTemplateState();
}
class _ListTemplateState extends State<ListTemplate> {
  CollectionReference templateCollection = FirebaseFirestore.instance.collection("Templates");
  Widget buildBody(){
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child : StreamBuilder<QuerySnapshot>(
        stream: templateCollection.snapshots(),
        builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return const Text("Failed to load data!");
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return ActivityServices.loadings();
          }
          return ListView(
            children : snapshot.data.docs.map((DocumentSnapshot doc){
              Template template;
              template = Template(
                doc['tid'],
                doc['name'],
                doc['desc'],
                doc['price'],
                doc['photo'],
              );
              return TemplateView(template:template);
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