import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController{
  CollectionReference notesRef = FirebaseFirestore.instance.collection('notes');
  CollectionReference archiveRef = FirebaseFirestore.instance.collection('archive');

  addData();
  transferData(String title, String note);
}

class HomeControllerImp extends HomeController{
  @override
  addData() async {
    await notesRef.doc().set({
      'title' : 'note 4',
      'note' : 'my name is faris'
    });
  }

  @override
  transferData(title, note) async {
    await archiveRef.doc().set({
      'title' : title,
      'note' : note,
    });
  }
}