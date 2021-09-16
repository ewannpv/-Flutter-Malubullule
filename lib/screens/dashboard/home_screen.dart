import 'package:malubullule/providers/drink_stats_provider.dart';
import 'package:malubullule/responsive.dart';
import 'package:flutter/material.dart';
import 'package:malubullule/constants.dart';
import 'package:provider/provider.dart';
import 'components/cards_list.dart';
import 'components/drinks_list.dart';
import 'components/stats_card.dart';
import 'components/storage_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch datas.
    context.read<DrinkStatsProvider>().updateCatalog();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const StatsCard(),
                      const CardsList(),
                      const SizedBox(height: defaultPadding),
                      const DrinksList(),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      // if (Responsive.isMobile(context)) const StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  const Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
