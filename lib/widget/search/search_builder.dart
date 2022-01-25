import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/widget/widget.dart';

typedef ChildrenFilter<T> = bool Function(T modal, String value);

typedef ChildrenBuilder<T> = Widget Function(T modal);

class QueryStreamBuilder<T> extends StatelessWidget {
  final Stream<QuerySnapshot<T>> stream;
  final ChildrenBuilder<T> builder;
  final ChildrenFilter<T> filter;
  final String? hintText;

  const QueryStreamBuilder({
    Key? key,
    this.hintText,
    required this.filter,
    required this.builder,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (_, AsyncSnapshot<QuerySnapshot<T>> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.docs ?? [];
          return data.isEmpty
              ? const EmptyView()
              : SearchView(data, filter, builder);
        }
        return Shimmer.fromColors(
          baseColor: Colors.blue,
          highlightColor: Colors.orange,
          child: const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}

class SearchView<T> extends StatefulWidget {
  final List<QueryDocumentSnapshot<T>> snapshot;
  final ChildrenBuilder<T> builder;
  final ChildrenFilter<T> filter;
  final String? hintText;

  const SearchView(
    this.snapshot,
    this.filter,
    this.builder, {
    Key? key,
    this.hintText,
  }) : super(key: key);

  @override
  State<SearchView<T>> createState() => _SearchViewState<T>();
}

class _SearchViewState<T> extends State<SearchView<T>> {
  final List<QueryDocumentSnapshot<T>> documents = [];
  final controller = TextEditingController();

  InputDecoration get decoration {
    return InputDecoration(
      hintText: widget.hintText ?? 'Search..',
      helperText: '',
    );
  }

  void search() {
    documents.clear();
    String value = controller.text;

    documents.addAll(value.isEmpty
        ? widget.snapshot
        : widget.snapshot
            .where((doc) => widget.filter(doc.data(), value))
            .toList());
    setState(() => debugPrint('Search $value => ${documents.length}'));
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(search);
    documents.addAll(widget.snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(12), children: [
      TextFormField(
        controller: controller,
        decoration: decoration,
      ),
      ...documents.map<Widget>(itemView).toList(),
    ]);
  }

  @override
  void didUpdateWidget(SearchView<T> widget) {
    super.didUpdateWidget(widget);
    search();
  }

  Widget itemView(QueryDocumentSnapshot<T> doc) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: widget.builder(doc.data()),
    );
  }
}
