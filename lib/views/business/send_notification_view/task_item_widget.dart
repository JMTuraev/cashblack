import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    Key? key,
    this.image,
    required this.onEditPressed,
  }) : super(key: key);

  final String? image;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x19ffffff),
          width: 0.20,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4f091e42),
            blurRadius: 1,
          ),
          BoxShadow(
            color: Color(0x3f091e42),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        color: const Color(0xff464648),
      ),
      child: Column(
        children: [
          image != null
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.asset(
                    // 'assets/images/notification/re-3.png',
                    'assets/images/email.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Konditsionerni almashtirish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: onEditPressed,
                    ),
                  ],
                ),
                // const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/watch-count.svg',
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/svg/clocks.svg',
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '19 apr',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/svg/clipboard-text.svg',
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/svg/skripka.svg',
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 48,
                      height: 24,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ClipOval(
                                child: Image.asset(
                                  // 'assets/images/notification/bo-1.png',
                                  'assets/images/email.png',
                                  fit: BoxFit.cover,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: ClipOval(
                                child: Image.asset(
                                  // 'assets/images/notification/bo-5.png',
                                  'assets/images/email.png',
                                  fit: BoxFit.fill,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: ClipOval(
                                child: Image.asset(
                                  // 'assets/images/notification/bo-8.png',
                                  'assets/images/email.png',
                                  fit: BoxFit.fill,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
