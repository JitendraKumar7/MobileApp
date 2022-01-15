import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: EmptyWidget(
          title: 'Empty',
          subTitle: 'No Record Found',
          packageImage: PackageImage.Image_2,
        ),
      );
}
