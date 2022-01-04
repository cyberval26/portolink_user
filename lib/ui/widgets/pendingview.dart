part of 'widgets.dart';

class PendingView extends StatefulWidget {
  const PendingView({Key key, this.pending}) : super(key: key);
  final Pending pending;
  @override
  _PendingViewState createState() => _PendingViewState();
}
class _PendingViewState extends State<PendingView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Pending pending = widget.pending;
    if(pending == null){
      return Container();
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
                        IconButton(
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
                                                    Row(
                                                      children: [
                                                        Icon(CupertinoIcons.news_solid),
                                                        Text("    "+pending.templateName, textAlign:TextAlign.center,),
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
                                                                   Text(pending.status),
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
                                                  label: Text("delete"),
                                                  onPressed: ()async {
                                                        bool hsl = await PendingServices.deletePending(pending.pendingId);
                                                        if (hsl) {
                                                            ActivityServices.showToast("delete succesfully",Colors.red);
                                                        } else {
                                                           ActivityServices.showToast("delete succesfully",Colors.red);
                                                        }
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
                        ),
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
