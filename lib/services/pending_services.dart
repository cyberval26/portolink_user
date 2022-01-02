part of'services.dart';

class PendingServices{
  //setup cloud firestore
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference pendingCollection = FirebaseFirestore.instance.collection("pending");
  static DocumentReference pendingDocument;
  //setup storage
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
      /* ref = FirebaseStorage.instance.ref().child("images").child(orderDocument.id+"jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(()=>
            ref.getDownloadURL().then((value) => imgUrl = value,)
         );*/
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