import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/widget/widget.dart';

typedef ChildBuilder<T> = Widget Function(List<QueryDocumentSnapshot<T>> docs);

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
          child: const Center(child: SpinKitWave(color: Colors.white)),
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

  void search() {
    documents.clear();
    String value = controller.text.toLowerCase();

    documents.addAll(value.isEmpty
        ? widget.snapshot
        : widget.snapshot
            .where((doc) => widget.filter(doc.data(), value))
            .toList());

    setState(() => true);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(search);
    documents.addAll(widget.snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(6), children: [
      TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: widget.hintText ?? 'Search..'),
      ),
      const SizedBox(height: 9),
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

class StreamLoader<T> extends StatelessWidget {
  final Stream<QuerySnapshot<T>> stream;
  final ChildBuilder<T> builder;
  final bool empty;

  const StreamLoader({
    Key? key,
    this.empty = false,
    required this.stream,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: stream,
        builder: (_, AsyncSnapshot<QuerySnapshot<T>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.docs ?? [];
            return (data.isEmpty && empty) ? const EmptyView() : builder(data);
          }
          return Shimmer.fromColors(
            baseColor: Colors.blue,
            highlightColor: Colors.orange,
            child: const Center(child: SpinKitWave(color: Colors.white)),
          );
        },
      ),
    );
  }
}
