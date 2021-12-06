
part of 'pages.dart';


class ListTemplate extends StatefulWidget {
  static const String routeName = "/listemplate";

  @override
  _ListTemplateState createState() => _ListTemplateState();
}

class _ListTemplateState extends State<ListTemplate> {
  CollectionReference templateCollection = FirebaseFirestore.instance.collection("template");

  Widget buildBody(){
    return Container(
        width: double.infinity,
        height: double.infinity,
        //mendeteksi perubahan data secara otomatis
        child : StreamBuilder<QuerySnapshot>(
          stream: templateCollection.snapshots(),
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
                Template template;
               // if (doc['templateId'] == null) {
                  template = Template(
                    doc['templateId'],
                    doc['templateName'],
                    doc['description'],
                    doc['price'],
                    doc['photoFile'],
                  );
               // }else{
               //   template = null;
               // }

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
      appBar: AppBar(
        title: Text("List Data"),
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
