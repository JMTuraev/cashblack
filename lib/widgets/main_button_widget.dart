import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../size_config.dart';

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
        SizedBox(
          width: double.infinity,
          height: getH(60),
          child: ElevatedButton(
            onPressed:
                (isLoading == null || isLoading == false) ? method : null,
            style: ButtonStyle(
              backgroundColor: color != null
                  ? MaterialStateProperty.all<Color?>(
                      color,
                    )
                  : MaterialStateProperty.all<Color?>(
                      const Color.fromRGBO(52, 200, 90, 1),
                    ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(16),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading == null || isLoading == false)
                  const SizedBox()
                else
                  SizedBox(
                    width: getW(26),
                    height: getH(26),
                  ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isLoading == null || isLoading == false)
                  const SizedBox()
                else
                  SizedBox(
                    width: getW(26),
                    height: getH(26),
                    child: const CupertinoActivityIndicator(
                      // strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (percent != null && percent! > 0)
          Positioned(
            top: 2,
            right: 3,
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.green[300],
                  borderRadius: const BorderRadius.all(
                Radius.circular(20),
              )),
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
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
        else
          const SizedBox(),
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
