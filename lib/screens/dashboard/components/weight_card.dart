import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:malubullule/providers/options_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class WeightCard extends StatefulWidget {
  const WeightCard({Key? key}) : super(key: key);

  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  final _controller = TextEditingController();

  @override
  initState() {
    super.initState();
    _controller.text = '30';
    getPrefs();
  }

  getPrefs() async {
    int weight = await context.read<OptionsProvider>().getGWeight();
    _controller.text = weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.weightCardLabelText,
              helperText: AppLocalizations.of(context)!.weightCardHelperText,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (value != "") {
                context.read<OptionsProvider>().updateWeight(int.parse(value));
              }
            },
          ),
        ],
      ),
    );
  }
}
