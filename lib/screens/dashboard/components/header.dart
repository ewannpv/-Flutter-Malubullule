import 'package:malubullule/controllers/menu_controller.dart';
import 'package:malubullule/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.maLubullule,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
