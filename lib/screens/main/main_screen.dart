import 'package:malubullule/constants.dart';
import 'package:malubullule/providers/menu_provider.dart';
import 'package:malubullule/responsive.dart';
import 'package:malubullule/screens/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuProvider>().scaffoldKey,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 2,
        title: Text(
          AppLocalizations.of(context)!.maLubullule,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.left,
        ),
        leading: IconButton(
            icon: const Icon(Icons.sports_bar_outlined),
            onPressed: () {} // context.read<MenuProvider>().controlMenu,
            ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: HomeScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
