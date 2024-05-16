// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../../size_config.dart';
// import '../../../../../string_extensions.dart';
// import '../../../../../view_models/sklad/sklad_view_model.dart';
// import 'prixod_history_view.dart';

// class PrixodHistoryListView extends StatefulWidget {
//   const PrixodHistoryListView({
//     super.key,
//   });

//   @override
//   State<PrixodHistoryListView> createState() => _PrixodHistoryListViewState();
// }

// class _PrixodHistoryListViewState extends State<PrixodHistoryListView> {
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     context.read<SkladViewModel>().clearFields();
//     super.initState();
//   }

//   int counter = 1;

//   @override
//   Widget build(BuildContext context) {
//     final model = context.read<SkladViewModel>();

//     // final skladPrixods = model.skladPrixods.reversed.toList();
//     final skladItems = model.skladItems.reversed.toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('История приходов'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: ListView.separated(
//           itemCount: skladItems.length,
//           separatorBuilder: (context, index) {
//             return const SizedBox(height: 10);
//           },
//           itemBuilder: (context, index) {
//             return ListTile(
//               // onDoubleTap: () {},
//               onTap: () {
//                 Navigator.of(context).push(
//                   CupertinoPageRoute(
//                     builder: (context) =>
//                         PrixodHistoryView(skladItem: skladItems[index]),
//                   ),
//                 );
//               },
//               title: Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         // 'Приход ${counter++}',
//                         skladItems[index].name,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         // skladPrixods[index].dateTime.getLocaleDateTime(),
//                         skladItems[index].createdDate.getLocaleDateTime(),
//                         style: const TextStyle(
//                           color: Color(0xff667084),
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         // skladPrixods[index].skladItems.length.toString(),
//                         skladItems[index].quantity.getFormattedNumber(),
//                         style: const TextStyle(
//                           color: Color(0xff34c85a),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         // skladPrixods[index].skladItems.length.toString(),
//                         skladItems[index].attribute,
//                         style: const TextStyle(
//                           color: Color(0xff34c85a),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // const SizedBox(width: 10),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class _GridWidget extends StatelessWidget {
//   const _GridWidget({
//     super.key,
//     required this.selections,
//   });

//   final List<String> selections;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: selections.length,
//       itemBuilder: (BuildContext context, int index) {
//         return DecoratedBox(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: const Color(0xff262629),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: getW(100),
//                 width: double.infinity,
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                   child: Image.asset(
//                     // 'assets/images/notification/bo-3.png',
//                     'assets/images/email.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       selections[index],
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       selections[index],
//                       style: const TextStyle(
//                         color: Color(0xff667084),
//                         fontSize: 14,
//                       ),
//                     ),
//                     const Text(
//                       '0',
//                       style: TextStyle(
//                         color: Color(0xff34c85a),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
