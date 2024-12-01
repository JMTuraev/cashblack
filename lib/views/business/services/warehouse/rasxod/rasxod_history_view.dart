// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../domain/models/services/sklad_rasxod.dart';
import '../../../../../string_extensions.dart';
import '../../../../../widgets/info_title_widget.dart';

class RasxodHistoryView extends StatefulWidget {
  // final Datum skladItem;
  final SkladRasxod skladItem;
  const RasxodHistoryView({
    super.key,
    required this.skladItem,
  });

  @override
  State<RasxodHistoryView> createState() => _RasxodHistoryViewState();
}

class _RasxodHistoryViewState extends State<RasxodHistoryView> {
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    // final model = context.read<SkladViewModel>();
    for (final element in widget.skladItem.rasxodItems) {
      totalPrice += double.parse(element.priceSellSingle.removeWhitespace()) *
          double.parse(element.quantity.toString().removeWhitespace());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали расхода'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Random().nextDouble().toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Серия',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.skladItem.dateTime.getLocaleDateTime(),
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
            const SizedBox(height: 10),
            Text(
              // 'widget.skladItem.total.getFormattedNumber()',
              widget.skladItem.rasxodItems.first.client,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Клиент',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              // 'widget.skladItem.total.getFormattedNumber()',
              totalPrice.toString().getAmountInSum(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Цена',
              style: TextStyle(
                color: Color(0xff667084),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Товары',
              style: TextStyle(
                // color: Color(0xff667084),
                fontSize: 18,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: widget.skladItem.rasxodItems.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  final product =
                      widget.skladItem.rasxodItems[index].warehouseItem;
                  // final attName = context
                  //     .read<SkladViewModel>()
                  //     .warehouseUnits
                  //     .where(
                  //       (element) =>
                  //           element.id.toString() ==
                  //           widget.skladItem.skladItems[index].unitId,
                  //     )
                  //     .first
                  //     .title;
                  final attName = product.unit;
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text('Наименование'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].product.name',
                                product.name,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Баркод'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].product.barCode',
                                product.barCode,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Склад'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].warehouse.name',
                                product.category.name,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Аттрибут'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].unit.title',
                                attName.title,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Количество'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].incomeQty.toString().getFormattedNumber()',
                                widget.skladItem.rasxodItems[index].quantity
                                    .toString(),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     const Text('Цена прихода'),
                      //     const Spacer(),
                      //     InfoTitleWidget(
                      //       title:
                      //           // 'widget.skladItem.products[index].price.getFormattedNumber()',
                      //           widget.skladItem.rasxodItems[index]
                      //               .priceSellSingle
                      //               .getAmountInSum(),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          const Text('Цена продажи'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].sellPrice.getFormattedNumber()',
                                widget.skladItem.rasxodItems[index]
                                    .priceSellSingle
                                    .getAmountInSum(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Общая цена'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].price.getFormattedNumber()',
                                widget.skladItem.rasxodItems[index].priceSellAll
                                    .getAmountInSum(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Теги'),
                          const Spacer(),
                          InfoTitleWidget(
                            title:
                                // 'widget.skladItem.products[index].price.getFormattedNumber()',
                                widget.skladItem.rasxodItems[index]
                                    .warehouseItem.tags
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            // Text(
            //   widget.skladItem.number.getFormattedNumber(),
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Text(
            //   'Количество',
            //   style: TextStyle(
            //     color: Color(0xff667084),
            //     fontSize: 14,
            //   ),
            // ),
            // const Divider(),
            // Text(
            //   model.warehouseProviders
            //       .where(
            //         (element) =>
            //             element.id.toString() == widget.skladItem.skladDeliever,
            //       )
            //       .first
            //       .name,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Text(
            //   'Поставщик',
            //   style: TextStyle(
            //     color: Color(0xff667084),
            //     fontSize: 14,
            //   ),
            // ),
            // const Divider(),
            // Text(
            //   widget.skladItem.serialNumber,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Text(
            //   'Сериал номер',
            //   style: TextStyle(
            //     color: Color(0xff667084),
            //     fontSize: 14,
            //   ),
            // ),
            // const Divider(),
            // const Text(
            //   'Склад',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Text(
            //   'Склад хранения',
            //   style: TextStyle(
            //     color: Color(0xff667084),
            //     fontSize: 14,
            //   ),
            // ),
            // const Divider(),
            // Text(
            //   model.skladItemStatuses
            //       .where(
            //         (element) =>
            //             element.value == widget.skladItem.skladItemStatus,
            //       )
            //       .first
            //       .name,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Text(
            //   'Статус',
            //   style: TextStyle(
            //     color: Color(0xff667084),
            //     fontSize: 14,
            //   ),
            // ),
            // const Divider(),
            // Text(
            //   widget.skladItem.serialNumber,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Text(
            //   'Баркод',
            //   style: TextStyle(
            //     color: Color(0xff667084),
            //     fontSize: 14,
            //   ),
            // ),
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
