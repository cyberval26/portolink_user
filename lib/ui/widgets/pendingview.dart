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
    if (pending == null) {
      return Container();
    }
    return Card(
      color: Colors.blue[100],
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                pending.templateName,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                maxLines: 1,
                softWrap: true,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.ellipsis_circle_fill),
                    color: Colors.blue,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext ctx) {
                          return SizedBox(
                            width: double.infinity,
                            height: 1000,
                            child: Stack(
                              children:<Widget>[
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: ListView(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(CupertinoIcons.news_solid),
                                              Text("    " + pending.color, textAlign:TextAlign.center),
                                            ]
                                          ),
                                          const SizedBox(height:24),
                                          Row(
                                            children: [
                                              Flexible(
                                                child:Container(
                                                  alignment:Alignment.center,
                                                  child: Column(
                                                    children: [
                                                      Text("Status : " + pending.status, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                                    ]
                                                  )
                                                )
                                              )
                                            ]
                                          ),
                                          const SizedBox(height:200),
                                        ]
                                      )
                                    ]
                                  )
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: const Icon(CupertinoIcons.trash),
                                        label: const Text("Delete"),
                                        onPressed: ()async {
                                          bool hsl = await PendingServices.deletePending(pending.pendingId);
                                          if (hsl) {
                                            ActivityServices.showToast("Delete Success", Colors.grey);
                                          } else {
                                            ActivityServices.showToast("Delete Failed", Colors.red);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          onPrimary: Colors.white,
                                          primary: Colors.deepPurple
                                        )
                                      )
                                    ]
                                  )
                                )
                              ]
                            )
                          );
                        }
                      );
                    }
                  )
                ]
              )
            ),
            Row(
              children: [
                Flexible(
                  child:Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.deepPurple,
                          width: 1
                        )
                      )
                    ),
                    alignment:Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          pending.status,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)
                        )
                      ]
                    )
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}