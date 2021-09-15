import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/logo.svg",
          height: 100,
        ),
      ],
    );
  }
}
