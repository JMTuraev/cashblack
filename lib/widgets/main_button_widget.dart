import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    Key? key,
    required this.text,
    required this.method,
    this.color,
    this.percent,
    this.isLoading,
  }) : super(key: key);

  final String text;
  final VoidCallback? method;
  final Color? color;
  final int? percent;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (percent != null && percent! > 0)
            ? Positioned(
                top: 2,
                right: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                  child: Text(
                    NumberFormat.simpleCurrency(
                          name: '',
                          locale: 'ru_RU',
                          decimalDigits: 0,
                        ).format(percent) +
                        'сум',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed:
                (isLoading == null || isLoading == false) ? method : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color?>(
                color,
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(16),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// if (percent != null && percent! > 0)
//                   Row(
//                     children: [
//                       const SizedBox(width: 2),
//                       Positioned(
//                         top: 0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.green[300],
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(10),
//                               )),
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 1, horizontal: 4),
//                           child: Text(
//                             NumberFormat.simpleCurrency(
//                                   name: '',
//                                   locale: 'ru_RU',
//                                   decimalDigits: 0,
//                                 ).format(percent) +
//                                 'сум',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 else
//                   const SizedBox(),
