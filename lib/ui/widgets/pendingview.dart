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
                    icon: const Icon(CupertinoIcons.shopping_cart),
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
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const SizedBox(height: 48),
                                              FadeInImage(
                                                placeholder: const NetworkImage(""),
                                                image: const NetworkImage(""),
                                                imageErrorBuilder: (ctx, exception, stackTrace) {
                                                  return Container();
                                                }
                                              ),
                                              const Text('Pesanan Anda', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.blue)),
                                              const SizedBox(height: 24),
                                              const Text('Status Pesanan', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                              const SizedBox(height: 1),
                                              Text(pending.status),
                                              const SizedBox(height: 24),
                                              const Text('Color', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                              const SizedBox(height: 1),
                                              Text(pending.color),
                                              const SizedBox(height: 24),
                                              const Text('Request Description', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                              const SizedBox(height: 1),
                                              Text(pending.description),
                                              const SizedBox(height: 24),
                                              const Text('Link Portofolio Website', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                              const SizedBox(height: 1),
                                              SelectableText(pending.link),
                                              const SizedBox(height: 24),
                                              Text('Reject Reason', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0, color: Colors.black)),
                                              const SizedBox(height: 1),
                                              Text(pending.reason)
                                            ]
                                          ),
                                          const SizedBox(height:50)
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
                                        icon: const Icon(CupertinoIcons.clear),
                                        label: const Text("Delete"),
                                        onPressed: () async {
                                          bool hsl = await PendingServices.deletePending(pending.pendingId);
                                          if (hsl) {
                                            ActivityServices.showToast("Delete Success", Colors.grey);
                                            Navigator.pushReplacementNamed(context, MainMenu.routeName);
                                          } else {
                                            ActivityServices.showToast("Delete Failed", Colors.red);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(primary: Colors.red)
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