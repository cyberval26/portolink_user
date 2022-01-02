part of 'services.dart';

class OrderServices{
  //setup cloud firestore
   static FirebaseAuth auth = FirebaseAuth.instance;
   static CollectionReference orderCollection = FirebaseFirestore.instance.collection("order");
   static CollectionReference pendingCollection = FirebaseFirestore.instance.collection("pending");
  // static CollectionReference pinsCollection = FirebaseFirestore.instance.collection("pins");
   static DocumentReference orderDocument;
   static DocumentReference pendingDocument;

   //setup storage
   static Reference ref;
   static UploadTask uploadTask;
   static String imgUrl;

   static Future<bool> addOrder(Order order,Pending pending, PickedFile imgFile) async{
      String dateNow = ActivityServices.dateNow();
      await Firebase.initializeApp();

      pendingDocument = await pendingCollection.add({
         'pendingId' : pending.pendingId,
         'templateName' : pending.templateName,
         'link' : pending.link,
         'color':pending.color,
         'description' : pending.description,
         'status' : "In Progress",
         'addBy':auth.currentUser.uid,
      });

      if(pendingDocument != null) {
         /* ref = FirebaseStorage.instance.ref().child("images").child(orderDocument.id+"jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(()=>
            ref.getDownloadURL().then((value) => imgUrl = value,)
         );*/

         pendingCollection.doc(pendingDocument.id).update(
             {
                'pendingId': pendingDocument.id,
             }
         );
      }

      orderDocument = await orderCollection.add({
         'orderId' : order.orderId,
         'templateName' : order.templateName,
         'color' : order.color,
         'contact' : order.contact,
         'requestDescription' : order.requestDescription,
         'photoReference' : order.photoReference,
         'addBy':auth.currentUser.uid,
         'pendingBy':pendingDocument.id,
         'status' : "In Progress",
         'createdAt' : dateNow,
      });


      if(orderDocument != null){
        /* ref = FirebaseStorage.instance.ref().child("images").child(orderDocument.id+"jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(()=>
            ref.getDownloadURL().then((value) => imgUrl = value,)
         );*/

         orderCollection.doc(orderDocument.id).update(
            {
               'orderId' : orderDocument.id,
            }
         );


         return true;
      }else{
         return false;
      }


   }


   static Future<bool> addRequest(Order order, PickedFile imgFile) async{
      String dateNow = ActivityServices.dateNow();
      await Firebase.initializeApp();
      orderDocument = await orderCollection.add({
         'orderId' : order.orderId,
         'templateName' : order.templateName,
         'color' : order.color,
         'contact' : order.contact,
         'requestDescription' : order.requestDescription,
         'photoReference' : order.photoReference,
         'addBy': auth.currentUser.uid,
         'createdAt' : dateNow,
      });
      if(orderDocument != null){
          ref = FirebaseStorage.instance.ref().child("images").child(orderDocument.id+"jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(()=>
            ref.getDownloadURL().then((value) => imgUrl = value,)
         );

         orderCollection.doc(orderDocument.id).update(
             {
                'orderId' : orderDocument.id,
                'photoReference' : imgUrl,
             }
         );

         return true;
      }else{
         return false;
      }
   }

   /*static Future<bool> deleteproduct(String id) async {
      bool hsl = true;
      bool hsp = true;
      await Firebase.initializeApp();
      await assignmentCollection.doc(id).delete().then((value) {
         hsl = true;
      }).catchError((onError){
         hsl = false;
      });

      if(hsl == true){
         await pinsCollection.doc(id).delete().then((value) {
            hsp = true;
         }).catchError((onError){
            hsp = false;
         });
      }
      return hsl;
   }*/

   /*static Future<bool> updateproduct(Assignment assignment,PickedFile imgFile, String id) async {
      bool hsl = true;
      await Firebase.initializeApp();
      await assignmentCollection.doc(id).update({
         'assignId' : assignment.assignId,
         'assignName' : assignment.assignName,
         'assignCourse' : assignment.assignCourse,
         'assignDeadline' : assignment.assignDeadline,
         'assignDesc' : assignment.assignDesc,
         'updatedAt' : assignment.updateAt,

      }).then((value) {
         hsl = true;
      }).catchError((onError){
         hsl = false;
      });
      if(imgFile != null) {
         ref = FirebaseStorage.instance.ref().child("images").child(id + "jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(() =>
             ref.getDownloadURL().then((value) => imgUrl = value,)
         );

         await assignmentCollection.doc(id).update(
             {
                'assignImage': imgUrl,
             }
         );
      }

      return hsl;
   }*/

}