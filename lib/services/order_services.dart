part of 'services.dart';

class OrderServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference orderCollection = FirebaseFirestore.instance.collection("Orders");
  static CollectionReference pendingCollection = FirebaseFirestore.instance.collection("Pendings");
  static DocumentReference orderDocument;
  static DocumentReference pendingDocument;
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;
  static Future<bool> addOrder(Order order, Pending pending, PickedFile imgFile) async {
    String dateNow = ActivityServices.dateNow();
    await Firebase.initializeApp();
    pendingDocument = await pendingCollection.add({
      'pendingId': pending.pendingId,
      'templateName': pending.templateName,
      'link': pending.link,
      'reason': pending.reason,
      'color': pending.color,
      'description': pending.description,
      'status': "In Progress",
      'addBy': auth.currentUser.uid
    });
    if (pendingDocument != null) {
      pendingCollection.doc(pendingDocument.id).update({
        'pendingId': pendingDocument.id
      });
    }
    orderDocument = await orderCollection.add({
      'orderId': order.orderId,
      'templateName': order.templateName,
      'color': order.color,
      'contact': order.contact,
      'requestDescription': order.requestDescription,
      'photoReference': order.photoReference,
      'addBy': auth.currentUser.uid,
      'pendingBy': pendingDocument.id,
      'status': "In Progress",
      'createdAt': dateNow
    });
    if (orderDocument != null) {
      orderCollection.doc(orderDocument.id).update({
        'orderId': orderDocument.id
      });
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> addRequest(Order order, Pending pending, PickedFile imgFile) async {
    String dateNow = ActivityServices.dateNow();
    await Firebase.initializeApp();
    pendingDocument = await pendingCollection.add({
      'pendingId': pending.pendingId,
      'templateName': pending.templateName,
      'link': pending.link,
      'reason': pending.reason,
      'color': pending.color,
      'description': pending.description,
      'status': "In Progress",
      'addBy': auth.currentUser.uid
    });
    if (pendingDocument != null) {
      pendingCollection.doc(pendingDocument.id).update({
        'pendingId': pendingDocument.id
      });
    }
    orderDocument = await orderCollection.add({
      'orderId': order.orderId,
      'templateName': order.templateName,
      'color': order.color,
      'contact': order.contact,
      'requestDescription': order.requestDescription,
      'photoReference': order.photoReference,
      'addBy': auth.currentUser.uid,
      'pendingBy': pendingDocument.id,
      'status': "In Progress",
      'createdAt': dateNow
    });
    if (orderDocument != null) {
      ref = FirebaseStorage.instance.ref().child("DesignRequestPhotos").child(orderDocument.id + "jpg");
      uploadTask = ref.putFile(File(imgFile.path));
      await uploadTask.whenComplete(() => ref.getDownloadURL().then((value) => imgUrl = value));
      orderCollection.doc(orderDocument.id).update({
        'orderId': orderDocument.id,
        'photoReference': imgUrl
      });
      return true;
    } else {
      return false;
    }
  }
}