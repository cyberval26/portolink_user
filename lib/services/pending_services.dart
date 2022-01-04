part of'services.dart';

class PendingServices{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference pendingCollection = FirebaseFirestore.instance.collection("Pendings");
  static DocumentReference pendingDocument;
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;
  static Future<bool> addPending(Pending pending, PickedFile imgFile) async{
    await Firebase.initializeApp();
    pendingDocument = await pendingCollection.add({
      'pendingId' : pending.pendingId,
      'templateName' : pending.templateName,
      'link' : pending.link,
      'color':pending.color,
      'description' : pending.description,
      'status' : "In Progress",
      'addBy':auth.currentUser.uid
    });
    if (pendingDocument != null) {
      pendingCollection.doc(pendingDocument.id).update({
        'pendingId' : pendingDocument.id
      });
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> deletePending(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await pendingCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError){
      hsl = false;
    });
    return hsl;
  }
}