import 'package:demo_flutter/models/Quotes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteItem extends StatefulWidget {
  final String id;
  const QuoteItem({Key? key, required this.id}) : super(key: key);

  @override
  _QuoteItemState createState() => _QuoteItemState();
}

class _QuoteItemState extends State<QuoteItem> {
  late DocumentReference quotes = Quotes.getQuotesByIDReference(widget.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quote Item'),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: quotes.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return Column(children: [
              Text(snapshot.data!.get("category") +
                  snapshot.data!.get("author")),
              IconButton(
                  onPressed: () {
                    Quotes.updateQuote(
                        widget.id,
                        snapshot.data!.get("author") + "ver",
                        snapshot.data!.get("category") + "ver");
                  },
                  icon: const Icon(Icons.edit, color: Colors.black26)),
            ]);
          },
        ));
  }
}