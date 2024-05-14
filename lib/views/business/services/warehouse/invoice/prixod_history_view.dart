// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/services/sklad_item.dart';
import '../../../../../string_extensions.dart';
import '../../../../../view_models/sklad/sklad_view_model.dart';

class PrixodHistoryView extends StatefulWidget {
  final SkladItem skladItem;
  const PrixodHistoryView({
    super.key,
    required this.skladItem,
  });

  @override
  State<PrixodHistoryView> createState() => _PrixodHistoryViewState();
}

class _PrixodHistoryViewState extends State<PrixodHistoryView> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<SkladViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали прихода'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.skladItem.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Название товара',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            Text(
              widget.skladItem.createdDate.getLocaleDateTime(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Дата и время прихода',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            Text(
              widget.skladItem.pricePrixod.getFormattedNumber(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Цена прихода',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            Text(
              widget.skladItem.quantity.getFormattedNumber(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Количество',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            Text(
              model.warehouseProviders
                  .where(
                    (element) =>
                        element.id.toString() == widget.skladItem.skladDeliever,
                  )
                  .first
                  .name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Поставщик',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            Text(
              widget.skladItem.serialNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Сериал номер',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              'Склад',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Склад хранения',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            Text(
              model.skladItemStatuses
                  .where(
                    (element) =>
                        element.value == widget.skladItem.skladItemStatus,
                  )
                  .first
                  .name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Статус',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const Divider(),
            Text(
              widget.skladItem.serialNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Баркод',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            // const Text(
            //   's',
            //   style: TextStyle(
            //     color: Color(0xff34c85a),
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
