import 'package:demo_flutter/models/Quotes.dart';
import 'package:demo_flutter/screens/quote_item.dart';
import 'package:flutter/material.dart';

class AuthorTile extends StatelessWidget {
  final String author;
  final String category;
  final String id;
  const AuthorTile(
      {Key? key,
      required this.author,
      required this.category,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuoteItem(id: id),
            ),
          );
        },
        child: Card(
          elevation: 5,
          child: Row(children: [
            Text(
              author,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              category,
              style: Theme.of(context).textTheme.caption,
            ),
            IconButton(
                onPressed: () {
                  Quotes.deleteQuote(id);
                },
                icon: const Icon(Icons.delete, color: Colors.black26)),
          ]),
        ));
  }
}
