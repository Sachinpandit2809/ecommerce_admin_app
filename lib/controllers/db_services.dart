import 'package:cloud_firestore/cloud_firestore.dart';
class DbServices {
  // CATEGORIES
  // read  categories from database 

    Stream<QuerySnapshot> readCategories(){
      return FirebaseFirestore.instance.collection("shop_categories").orderBy("priority", descending: true) .snapshots();
    } 
    // create new categories 
    Future createCategories({required Map<String, dynamic> data }  ) async {
      await FirebaseFirestore.instance.collection("shop_categories").add(data);
    }
    // update categories 
    Future updateCategories ({ required String docId , required Map<String,dynamic> data}) async{
      await FirebaseFirestore.instance.collection("shop_categories").doc(docId).update(data); 
    }
    // delete categories
    Future deleteCategories({required String docId})async{
      await FirebaseFirestore.instance.collection("shop_categories").doc(docId).delete(); 

    }

  }
