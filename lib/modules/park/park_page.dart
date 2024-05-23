import 'package:flutter/material.dart';
import 'package:vagalivre/modules/home/controllers/parks_search_controller.dart';
import 'package:vagalivre/utils/formatters.dart';

class ParkPage extends StatelessWidget {
  const ParkPage({super.key, required this.park});

  final ParkResult park;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final today = DateTime.now();

    final hasSlots = park.slotsCount > 0;

    var sectionTitleStyle =
        textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSecondaryContainer);

    return Scaffold(
      appBar: AppBar(title: Text(park.label)),
      body: DefaultTextStyle(
        style: TextStyle(color: theme.colorScheme.onSurface),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox.fromSize(
              size: const Size.fromHeight(180),
              child: const Placeholder(),
            ),
            Text(park.label, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${weekdayFormatter.format(today).toCapitalized()}: "
                  "${currencyFormatter.format(park.price)} por hora",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                FilledButton(onPressed: null, child: const Text("Reservar Vaga")),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Descrição", style: sectionTitleStyle),
                Text(park.description, style: textTheme.bodyMedium),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contatos", style: sectionTitleStyle),
                const Text("Informações de contato indisponíveis"),
              ],
            ),
          ].expand((element) => [element, const SizedBox.square(dimension: 16)]).toList(),
        ),
      ),
    );
  }
}
