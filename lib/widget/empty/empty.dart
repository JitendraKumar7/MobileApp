import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/empty.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(36),
        alignment: Alignment.center,
        /*
        child: EmptyWidget(
          title: 'Empty',
          subTitle: 'No Record Found',
          packageImage: PackageImage.Image_2,
        ),
        */
      );
}
