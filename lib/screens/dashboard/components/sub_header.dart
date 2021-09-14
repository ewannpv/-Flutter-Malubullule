import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constants.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.headerSubtitle,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: defaultPadding,
          height: 20,
        ),
      ],
    );
  }
}
