// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../widgets/x_file_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../utils/constants.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_notifications_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../widgets/active_switcher_widget.dart';
import '../../../widgets/inactive_switcher_widget.dart';
import '../../../widgets/info_alert_widget.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/multiline_text_field_widget.dart';
import '../scanner_view/payment_phone_view.dart';

class SendNotificationView extends StatefulWidget {
  const SendNotificationView({super.key});

  @override
  State<SendNotificationView> createState() => _SendNotificationViewState();
}

class _SendNotificationViewState extends State<SendNotificationView> {
  // final ImagePicker _picker = ImagePicker();
  // List<File?> _fileList = [];
  XFile? _file;

  // void dltImages(data) {
  //   setState(() {
  //     _fileList.remove(data);
  //   });
  // }

  // void selectImage() async {
  //   final XFile? image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 1080,
  //     maxWidth: 1080,
  //     // imageQuality: 75,
  //   );
  //   setState(() {
  //     File? file = File(image!.path);
  //     _fileList.add(file);
  //   });
  // }

  Future<void> getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (pickedFile != null) {
      print(pickedFile);
      setState(() {
        _file = pickedFile;
      });
    }
  }

  final TextEditingController _titleController = TextEditingController(
    text: 'Бонус-3',
  );
  final TextEditingController _contentController = TextEditingController();

  // late Future prices;

  @override
  void initState() {
    // context.read<BusinessNotificationsViewModel>().getPrices();
    super.initState();
  }

  List<bool> selections = [false, true, false];

  int selectedItem = 0;

  String? selectedShop;

  @override
  Widget build(BuildContext context) {
    final balance =
        context.read<BusinessSettingsViewModel>().businessProfile!.balance;
    final subPrice = context
        .read<BusinessNotificationsViewModel>()
        .prices
        .where(
          (element) => element.id == 2,
        )
        .first
        .price;
    // String price = context.watch<SendNotificationViewModel>().notificationPrice;

    final prices2 = context.read<BusinessNotificationsViewModel>().prices;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Отправка уведомлений'),
          // bottom: ThemeDetails.appBarDivider,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(28, 28, 29, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: selections[0] == true
                        ? [
                            Expanded(
                              child: ActiveSwitcherWidget(
                                fontSize: 16,
                                color: const Color.fromRGBO(103, 206, 103, 1),
                                title: 'Акция',
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: getW(4)),
                            Expanded(
                              child: InactiveSwitcherWidget(
                                fontSize: 16,
                                color: Colors.white,
                                title: 'Бонус',
                                onPressed: () {
                                  setState(() {
                                    selectedItem = 0;
                                    selections = [false, true, false];
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: getW(4)),
                            Expanded(
                              child: InactiveSwitcherWidget(
                                fontSize: 16,
                                color: Colors.white,
                                title: 'Реклама',
                                onPressed: () {
                                  setState(() {
                                    selectedItem = 0;
                                    selections = [false, false, true];
                                  });
                                },
                              ),
                            ),
                          ]
                        : (selections[1] == true)
                            ? [
                                Expanded(
                                  child: InactiveSwitcherWidget(
                                    color: Colors.white,
                                    fontSize: 16,
                                    title: 'Акция',
                                    onPressed: () {
                                      setState(() {
                                        selectedItem = 0;
                                        selections = [true, false, false];
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: getW(4)),
                                Expanded(
                                  child: ActiveSwitcherWidget(
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(103, 206, 103, 1),
                                    title: 'Бонус',
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: getW(4)),
                                Expanded(
                                  child: InactiveSwitcherWidget(
                                    fontSize: 16,
                                    title: 'Реклама',
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        selectedItem = 0;
                                        selections = [false, false, true];
                                      });
                                    },
                                  ),
                                ),
                              ]
                            : [
                                Expanded(
                                  child: InactiveSwitcherWidget(
                                    fontSize: 16,
                                    title: 'Акция',
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        selectedItem = 0;
                                        selections = [true, false, false];
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: getW(4)),
                                Expanded(
                                  child: InactiveSwitcherWidget(
                                    fontSize: 16,
                                    title: 'Бонус',
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        selectedItem = 0;
                                        selections = [false, true, false];
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: getW(4)),
                                Expanded(
                                  child: ActiveSwitcherWidget(
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(103, 206, 103, 1),
                                    onPressed: () {},
                                    title: 'Реклама',
                                  ),
                                ),
                              ],
                  ),
                ),
                SizedBox(height: getH(20)),
                _file == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _BigImageCardWidget(
                          image: selections[0] == true
                              ? Constants.actionImages[selectedItem]
                              : (selections[1] == true
                                  ? Constants.cashbackImages[selectedItem]
                                  : Constants.adImages[selectedItem]),
                        ),
                      )
                    : _ImageViewWidget(
                        file: _file!,
                        onTap: () {
                          setState(() {
                            _file = null;
                          });
                        },
                      ),
                SizedBox(height: getH(20)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SelectCategoryWidget(
                    categoryItems: context
                        .read<BusinessDashboardViewModel>()
                        .businessShops!
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e.id.toString(),
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    hint: 'Магазин',
                    onChanged: (String value) {
                      // print(value);
                      selectedShop = value;
                    },
                    selectedOption: selectedShop,
                  ),
                ),
                SizedBox(height: getH(20)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MultilineTextFieldWidget(
                    onTap: getFromGallery,
                    hintText: 'Что у вас нового?',
                    controller: _contentController,
                  ),
                ),
                // const Spacer(),
                SizedBox(height: getH(10)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      if (selections[0] == true)
                        cardBuilder(Constants.actionImages, 'Акция')
                      else
                        selections[1] == true
                            ? cardBuilder(Constants.cashbackImages, 'Бонус')
                            : cardBuilder(Constants.adImages, 'Реклама'),
                      // Positioned(
                      //   top: 0,
                      //   left: 0,
                      //   bottom: 0,
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       gradient: LinearGradient(
                      //         begin: Alignment.centerLeft,
                      //         end: Alignment.centerRight,
                      //         colors: [
                      //           Colors.black,
                      //           Colors.black12,
                      //           Colors.transparent,
                      //         ],
                      //       ),
                      //     ),
                      //     width: 30,
                      //   ),
                      // ),
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   bottom: 0,
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       gradient: LinearGradient(
                      //         begin: Alignment.centerRight,
                      //         end: Alignment.centerLeft,
                      //         colors: [
                      //           Colors.black,
                      //           Colors.black12,
                      //           Colors.transparent,
                      //         ],
                      //       ),
                      //     ),
                      //     width: 30,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: getH(20)),
                Text(
                  'Цена ${subPrice.getAmountInSum()}',
                ),
                SizedBox(height: getH(20)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      MainButtonWidget(
                        text: 'Отправить',
                        isLoading: false,
                        method: () async {
                          print(_titleController.text);
                          print(_contentController.text);
                          print(balance);
                          print(subPrice);

                          if (

                              // _fileList.isNotEmpty &&
                              selectedItem != -1 &&
                                  _titleController.text != -1 &&
                                  _titleController.text.isNotEmpty &&
                                  _contentController.text.isNotEmpty) {
                            if (double.parse(balance) <
                                double.parse(subPrice)) {
                              // showCupertinoDialog(
                              //   context: context,
                              //   builder: (context) =>
                              //       InfoAlertWidget(title: 'Пополните баланс'),
                              await showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return const InfoAlertWidget(
                                    title:
                                        'Пополните баланс для отправки уведомлений',
                                  );
                                },
                              );
                              // );
                            } else {
                              await context
                                  .read<BusinessNotificationsViewModel>()
                                  .postNotification(
                                    // _fileList[0]!,
                                    // _titleController.text,
                                    // _contentController.text,
                                    2,
                                    _titleController.text,
                                    _contentController.text,
                                    _titleController.text,
                                    selectedShop ?? '',
                                    _file,
                                  )
                                  .then(
                                (value) {
                                  if (value) {
                                    context
                                        .read<BusinessSettingsViewModel>()
                                        .getOwnerProfile(); // profil
                                    context
                                        .read<BusinessNotificationsViewModel>()
                                        .getNotifications();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                },
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: Future.delayed(Duration.zero),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              'Отправленные уведомления увидят пользователи, которые вы выплатили кэшбэк (23 пользователей). Цена одного уведомление составляет ${NumberFormat.simpleCurrency(
                                name: '',
                                locale: 'ru_RU',
                                decimalDigits: 0,
                              ).format(int.parse(snapshot.data.toString()))}сумов и будет видна в течение 48 часов (после подтверждения).',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      ),
                      SizedBox(height: getH(20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox cardBuilder(List imagesList, String type) {
    return SizedBox(
      height: getH(52),
      width: double.infinity,
      child: ListView.separated(
        key: ObjectKey(imagesList[0]),
        scrollDirection: Axis.horizontal,
        itemCount: imagesList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedItem = index;
              final ind = imagesList[index]
                  .split('-')
                  .last
                  .toString()
                  .split('.png')
                  .first;

              _titleController.text = '$type-$ind';
            });
          },
          child: selectedItem == index
              ? _ImageCardWidget(
                  image: imagesList[index].toString(),
                  selectedIndex: true,
                )
              : _ImageCardWidget(
                  image: imagesList[index].toString(),
                  selectedIndex: false,
                ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: getW(10),
        ),
      ),
    );
  }
}

class _ImageCardWidget extends StatelessWidget {
  const _ImageCardWidget({
    super.key,
    required this.image,
    this.selectedIndex,
  });

  final String image;
  final bool? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getH(50),
          width: getH(70),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: selectedIndex == true
                ? Border.all(
                    width: 2,
                    color: Colors.green,
                  )
                : Border.all(
                    width: 2,
                    color: Colors.transparent,
                  ),
          ),
          child: ClipRRect(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // selectedIndex == true
        //     ? Positioned(
        //         right: getW(8),
        //         top: getW(8),
        //         child: Container(
        //           padding: const EdgeInsets.all(0.00011),
        //           decoration: const BoxDecoration(
        //             // boxShadow: [
        //             //   BoxShadow(
        //             //     color: Colors.white.withOpacity(0.1),
        //             //     spreadRadius: 0.1,
        //             //     blurRadius: 0.1,
        //             //     offset: Offset(0.1, 0.1),
        //             //   )
        //             // ],
        //             color: Colors.white,
        //             borderRadius: BorderRadius.all(
        //               Radius.circular(90),
        //             ),
        //           ),
        //           child: const Icon(
        //             Icons.check_circle,
        //             size: 30,
        //             color: Color.fromRGBO(103, 206, 103, 1),
        //           ),
        //         ))
        //     : const SizedBox()
      ],
    );
  }
}

class _BigImageCardWidget extends StatelessWidget {
  const _BigImageCardWidget({
    super.key,
    required this.image,
    this.selectedIndex,
  });

  final String image;
  final bool? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getH(300),
      // width: getH(300),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ImageViewWidget extends StatelessWidget {
  final XFile file;
  final VoidCallback onTap;
  const _ImageViewWidget({
    super.key,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(1),
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: getH(300),
              width: double.infinity,
              child: XFileImage(
                file,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 2,
              child: GestureDetector(
                onTap: onTap,
                child: const Icon(Icons.cancel, color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilePickerWidget extends StatelessWidget {
  const _FilePickerWidget({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      // onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.grey[800],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          // width: getW(200),
          height: getH(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/svg/gallery.svg',
                width: getW(22),
                height: getH(22),
              ),
              const SizedBox(width: 10),
              const Text(
                'Выберите картинку',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
