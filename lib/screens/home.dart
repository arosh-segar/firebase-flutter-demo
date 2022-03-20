import 'package:demo_flutter/components/author_tile.dart';

import '../models/Quotes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  static const String routeName = '/';
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference quotes = Quotes.getQuotesReference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(56, 75, 49, 1.0),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                /* Navigator.of(context).pushNamed(Cart.routeName); */
              },
            )
          ],
          title: const Text('Home'),
        ),
        body: StreamBuilder(
          stream: quotes.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    children: snapshot.data!.docs
                        .map((e) => AuthorTile(
                              author: e['author'],
                              category: e['category'],
                              id: e.reference.id,
                            ))
                        .toList()),
                TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.blue.withOpacity(0.04);
                          }
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) {
                            return Colors.blue.withOpacity(0.12);
                          }
                          return null; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      Quotes.addQuote("Arosh", "Life", "quote 1");
                    },
                    child: const Text('Add Quote'))
              ],
            );
          },
        ));
  }
}
