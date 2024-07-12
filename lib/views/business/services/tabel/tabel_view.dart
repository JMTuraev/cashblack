// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../../../../size_config.dart';

// class TabelView extends StatelessWidget {
//   const TabelView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Табель'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DecoratedBox(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(13),
//                 color: const Color(0xff262629),
//               ),
//               child: TableCalendar(
//                 locale: 'ru_RU',
//                 startingDayOfWeek: StartingDayOfWeek.monday,
//                 focusedDay: DateTime.now(),
//                 firstDay: DateTime.now().subtract(const Duration(days: 30)),
//                 lastDay: DateTime.now().add(const Duration(days: 30)),
//                 sixWeekMonthsEnforced: true,
//                 calendarStyle: const CalendarStyle(
//                   isTodayHighlighted: true,
//                   markerSizeScale: 0.5,
//                   rangeHighlightColor: Colors.greenAccent,
//                 ),
//                 availableCalendarFormats: const {
//                   CalendarFormat.month: 'Month',
//                 },
//                 headerStyle: const HeaderStyle(
//                   titleCentered: true,
//                   titleTextStyle: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18,
//                   ),
//                 ),
//                 rangeSelectionMode: RangeSelectionMode.toggledOn,
//                 rangeStartDay: DateTime.now().add(const Duration(days: 2)),
//                 rangeEndDay: DateTime.now().add(const Duration(days: 4)),
//                 calendarBuilders: CalendarBuilders(
//                   defaultBuilder: (context, day, focusedDay) {
//                     return Center(
//                       child: Text(
//                         '${day.day}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           // fontWeight: FontWeight.w500,
//                           color: Color(0xff34c85a),
//                         ),
//                       ),
//                     );
//                   },
//                   rangeStartBuilder: (context, day, focusedDay) {
//                     return Center(
//                       child: Container(
//                         height: getW(40),
//                         width: getW(40),
//                         decoration: const BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(90),
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Center(
//                               child: Text(
//                                 '${day.day}',
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   rangeEndBuilder: (context, day, focusedDay) {
//                     return Center(
//                       child: Container(
//                         height: getW(40),
//                         width: getW(40),
//                         decoration: const BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(90),
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Center(
//                               child: Text(
//                                 '${day.day}',
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   rangeHighlightBuilder: (context, day, isWithinRange) {},
//                   withinRangeBuilder: (context, day, focusedDay) {
//                     return Center(
//                       child: Text(
//                         '${day.day}',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Сотрудники',
//               style: TextStyle(
//                 color: Color(0xff72777a),
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.separated(
//                 itemCount: 20,
//                 separatorBuilder: (context, index) {
//                   return SizedBox(height: 10);
//                 },
//                 itemBuilder: (context, index) {
//                   return _ItemWidget();
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ItemWidget extends StatelessWidget {
//   const _ItemWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: const Color(0xff4d3b00),
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           Container(
//             width: getW(50),
//             height: getW(50),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(90),
//                 color: const Color.fromRGBO(238, 221, 0, 0.5)),
//             child: const Center(
//                 child: Text(
//               'JD',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             )),
//           ),
//           const SizedBox(width: 10),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text(
//                 'John Doe',
//                 style: TextStyle(
//                   color: Color(0xfffdc500),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 'Кассир',
//                 style: TextStyle(
//                   color: Color(0xfffdc500),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: const [
//               Text(
//                 'Опоздал',
//                 style: TextStyle(
//                   color: Color(0xfffdc500),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 '13:20',
//                 style: TextStyle(
//                   color: Color(0xfffdc500),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 10),
//           Icon(
//             Icons.watch_later_sharp,
//             color: const Color(0xfffdc500),
//             size: getW(30),
//           ),
//         ],
//       ),
//     );
//   }
// }
