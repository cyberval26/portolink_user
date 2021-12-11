part of 'widgets.dart';


class PendingView extends StatefulWidget {
  static const String routeName = "/pendingview";
  final Pending pending;
  PendingView({this.pending});


  @override
  _PendingViewState createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  bool isLoading = false;
  //CollectionReference assignmentCollection = FirebaseFirestore.instance.collection("assignment");

  @override
  Widget build(BuildContext context) {
    Pending pending = widget.pending;
    if(pending == null){
      return Scaffold(
           appBar: AppBar(
           title:Text('gagal EHE'+pending.pendingId),
           centerTitle : true,
           elevation : 0,
       ),
      );
    }else {
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0)
        ),
        margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 24.8,
                    //backgroundImage: NetworkImage(template.templateName),
                  ),
                  title: Text(
                    pending.templateName, style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,),
                    maxLines: 1,
                    softWrap: true,
                  ),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                              CupertinoIcons.add
                              ,color: Colors.black,
                          ),
                          onPressed: (){
                           /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderTemplate(
                                      templateId: template.templateId,
                                      templateName: template.templateName,
                                      description: template.description,
                                      price: template.price,
                                      photoFile :template.photoFile,
                                    )));*/
                          },
                        ),
                        /*IconButton(
                          icon: Icon(Icons.more_horiz_rounded,
                            color: Colors.blue,),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return Container(
                                    //alignment: Alignment.bottomCenter,
                                     width: double.infinity,
                                      height: 1000,
                                     // padding: EdgeInsets.all(0),
                                    child: Stack(
                                        children:<Widget>[
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            child: ListView(
                                              // mainAxisAlignment: MainAxisAlignment
                                              //    .spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Image(
                                                        height: 300,
                                                        image:NetworkImage(template.photoFile),
                                                      ),
                                                    ),
                                                    SizedBox(height:24,),
                                                    Row(
                                                      children: [
                                                        Icon(CupertinoIcons.news_solid),
                                                        Text("    "+template.templateName, textAlign:TextAlign.center,),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.description),
                                                        Text("    "+template.description),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.lock_clock),
                                                        Text("    "+template.price),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                           child:Container(
                                                             alignment:Alignment.center,
                                                               child: Column(
                                                                 children: [
                                                                   Text("Description :",textAlign: TextAlign.left ,style: TextStyle(fontWeight: FontWeight.bold),),
                                                                   SizedBox(height :10),
                                                                   Text(template.description),
                                                                 ],
                                                               )
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height:200),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                             mainAxisAlignment: MainAxisAlignment
                                                 .spaceEvenly,
                                              children: [
                                                ElevatedButton.icon(
                                                  icon: const Icon(CupertinoIcons
                                                      .pin_fill),
                                                  label: Text("Pins data"),
                                                  onPressed: ()async {
                                                     /* setState(() {
                                                        isLoading = true;
                                                      });
                                                      Pins pins = Pins("",assignment.assignName,assignment.assignCourse,
                                                          assignment.assignDeadline,assignment.assignDesc,assignment.assignImage,"",FirebaseAuth.instance.currentUser.uid,"","");
                                                      await PinsServices.addPins(pins).then((value){
                                                        if(value == true){
                                                          ActivityServices.showToast("pins data succes", Colors.green);
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }else{
                                                          ActivityServices.showToast("pins data failed", Colors.red);
                                                        }
                                                      });*/
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      onPrimary: Colors.white,
                                                      primary: Colors.deepPurple
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]
                                    ),
                                  );
                                }
                            );
                          },
                        ),*/
                      ]
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                        child:Container(
                          padding: EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.deepPurple,
                                width: 1,
                              ),
                            ),
                          ),
                            alignment:Alignment.center,
                            child: Column(
                              children: [
                                Text(pending.status, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              ],
                            )
                        )
                    )
                  ],
                ),
               // Text("Course : "+assignment.assignCourse, textAlign: TextAlign.center)
              ],
            )

        ),
      );
    }

  }
}
