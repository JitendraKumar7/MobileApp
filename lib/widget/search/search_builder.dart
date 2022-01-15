import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/widget/widget.dart';

typedef SearchWidgetBuilder<T> = Widget Function(
    List<QueryDocumentSnapshot<T>> snapshot);

class SearchStreamBuilder<T> extends StatelessWidget {
  final TextEditingController controller;
  final Stream<QuerySnapshot<T>> stream;
  final SearchWidgetBuilder<T> builder;
  final String? hintText;

  const SearchStreamBuilder({
    Key? key,
    this.hintText,
    required this.stream,
    required this.builder,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var decoration = InputDecoration(hintText: hintText ?? 'Search..');
    return StreamBuilder(
      stream: stream,
      builder: (_, AsyncSnapshot<QuerySnapshot<T>> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.docs ?? [];
          return data.isEmpty
              ? const EmptyView()
              : ListView(padding: const EdgeInsets.all(12), children: [
                  TextFormField(
                    controller: controller,
                    decoration: decoration,
                  ),
                  const SizedBox(height: 6),
                  builder(data),
                ]);
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.blue,
          child: const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}
