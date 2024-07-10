import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagalivre/config/extension.dart';
import 'package:vagalivre/modules/home/controllers/parks_search_controller.dart';
import 'package:vagalivre/utils/formatters.dart';
import 'package:vagalivre/utils/initial_letters.dart';

class ParkResultCard extends StatelessWidget {
  const ParkResultCard({
    super.key,
    required this.park,
    required this.width,
    required this.textTheme,
  });

  final ParkResult park;
  final double width;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final pluralSlots = park.slotsCount != 1;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.hardEdge,
      surfaceTintColor: Colors.transparent,
      color: context.colorScheme.onPrimary,
      child: InkWell(
        onTap: () => context.read<ParksSearchController>().selectPark(park),
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.all(0),
                leading: CircleAvatar(
                  child: Text(initialLetters(park.label)),
                ),
                titleTextStyle: textTheme.titleMedium,
                title: Text(
                  park.label,
                  maxLines: 2,
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 2.0, top: 2),
                      child: Icon(Icons.pentagon, size: 14),
                    ),
                    const SizedBox.square(dimension: 4),
                    Expanded(
                      child: Text(
                        park.address,
                        style: textTheme.bodySmall,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox.square(dimension: 6),
              Text("${currencyFormatter.format(park.price)}/hora"),
              Text(
                "${park.slotsCount} "
                "${pluralSlots ? "espaços" : "espaço"} "
                "${pluralSlots ? "disponíveis" : "disponível"}",
              ),
              const Divider(height: 8),
              Expanded(
                child: Text(
                  park.description,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
