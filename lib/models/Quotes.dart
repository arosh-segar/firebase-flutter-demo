import 'package:cloud_firestore/cloud_firestore.dart';

class Quotes {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference quotesCollectionReference =
      firestore.collection("quotes");

  static CollectionReference getQuotesReference() {
    return quotesCollectionReference;
  }

  static DocumentReference getQuotesByIDReference(String id) {
    return quotesCollectionReference.doc(id);
  }

  static Future<dynamic> addQuote(
      String author, String category, String quoteText) {
    return quotesCollectionReference
        .add({'author': author, 'category': category, 'quoteText': quoteText})
        // ignore: avoid_print
        .then((value) => print("Quote Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add quote: $error"));
  }

  static Future<dynamic> deleteQuote(String id) {
    return quotesCollectionReference
        .doc(id)
        .delete()
        // ignore: avoid_print
        .then((value) => print("Quote Deleted"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to delete quote: $error"));
  }

  static Future<dynamic> updateQuote(
      String id, String author, String category) {
    return quotesCollectionReference
        .doc(id)
        .update({'author': author, 'category': category})
        // ignore: avoid_print
        .then((value) => print("Quote Updated"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update quote: $error"));
  }
}
