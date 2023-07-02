import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;
  static const double defaultPadding = 16.0;
  static const Color primaryColor = Color(0xFF2967FF);
  static const Color grayColor = Color(0xFF8D8D8E);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 116, 154, 249),
        highlightColor: const Color.fromARGB(255, 175, 250, 167),
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultPadding))),
        ));
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
