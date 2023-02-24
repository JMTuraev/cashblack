import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../view_models/send_notification_view_model.dart';
import '../../../widgets/info_alert_widget.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/multiline_text_field_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../business_home_view/business_home_view.dart';

class SendNotificationView extends StatefulWidget {
  const SendNotificationView({super.key});

  @override
  State<SendNotificationView> createState() => _SendNotificationViewState();
}

class _SendNotificationViewState extends State<SendNotificationView> {
  final ImagePicker _picker = ImagePicker();
  List<File?> _fileList = [];

  void dltImages(data) {
    setState(() {
      _fileList.remove(data);
    });
  }

  void selectImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
      // imageQuality: 75,
    );
    setState(() {
      File? file = File(image!.path);
      _fileList.add(file);
    });
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late Future prices;

  @override
  void initState() {
    prices = context.read<SendNotificationViewModel>().getNotificationPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String balance =
        context.watch<BusinessHomeViewModel>().balance.first.amount;
    String price = context.watch<SendNotificationViewModel>().notificationPrice;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Отправка уведомлений'),
          // bottom: ThemeDetails.appBarDivider,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                children: [
                  // Image.asset(
                  //   'assets/images/email.png',
                  //   fit: BoxFit.contain,
                  //   height: MediaQuery.of(context).size.width / 2.5,
                  // ),
                  SizedBox(height: getH(58)),
                  _fileList.isEmpty
                      ? _FilePickerWidget(onTap: selectImage)
                      : _ImageViewWidget(
                          fileList: _fileList,
                          onTap: () {
                            dltImages(_fileList.first);
                          },
                        ),
                  SizedBox(height: getH(20)),
                  TextFieldWidget(
                    hintText: 'Заголовок',
                    controller: _titleController,
                  ),
                  SizedBox(height: getH(20)),
                  MultilineTextFieldWidget(
                    hintText: 'Текст',
                    controller: _contentController,
                  ),
                  // const Spacer(),
                  SizedBox(height: getH(20)),

                  FutureBuilder(
                    future: prices,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Цена ${NumberFormat.simpleCurrency(
                            name: '',
                            locale: 'ru_RU',
                            decimalDigits: 0,
                          ).format(int.parse(snapshot.data.toString()))}сумов',
                        );
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                  SizedBox(height: getH(20)),

                  MainButtonWidget(
                    text: 'Отправить',
                    method: () async {
                      if (int.parse(balance) < int.parse(price)) {
                        // showCupertinoDialog(
                        //   context: context,
                        //   builder: (context) =>
                        //       InfoAlertWidget(title: 'Пополните баланс'),
                        await showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return const InfoAlertWidget(
                              title: 'Пополните баланс',
                            );
                          },
                        );
                        // );
                      } else {
                        await context
                            .read<SendNotificationViewModel>()
                            .send(
                              _fileList[0]!,
                              _titleController.text,
                              _contentController.text,
                            )
                            .then(
                              (value) =>
                                  Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const BusinessHomeView(),
                                ),
                                (route) => false,
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageViewWidget extends StatelessWidget {
  const _ImageViewWidget({
    Key? key,
    required List<File?> fileList,
    required this.onTap,
  })  : _fileList = fileList,
        super(key: key);

  final List<File?> _fileList;
  final Function onTap;

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
              height: getH(200),
              width: double.infinity,
              child: Image.file(
                File(_fileList.first!.path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 2,
              child: GestureDetector(
                onTap: () => onTap(),
                child: const Icon(Icons.cancel, color: Colors.redAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FilePickerWidget extends StatelessWidget {
  const _FilePickerWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.grey[800],
        ),
        child: SizedBox(
          width: getW(200),
          height: getH(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
