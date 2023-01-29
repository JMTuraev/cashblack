import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_details.dart';
import '../../../view_models/send_notification_view_model.dart';
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
    // TODO: implement initState
    prices = context.read<SendNotificationViewModel>().getNotificationPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Отправка уведомлений'),
          bottom: ThemeDetails.appBarDivider,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/email.png',
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.width / 2.5,
                  ),
                  _fileList.isEmpty
                      ? _FilePickerWidget(onTap: selectImage)
                      : _ImageViewWidget(
                          fileList: _fileList,
                          onTap: () {
                            dltImages(_fileList.first);
                          },
                        ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    hintText: 'Заголовок',
                    controller: _titleController,
                  ),
                  const SizedBox(height: 20),
                  MultilineTextFieldWidget(
                    hintText: 'Текст',
                    controller: _contentController,
                  ),
                  const SizedBox(height: 20),
                  MainButtonWidget(
                    text: 'Отправить',
                    method: () async {
                      await context
                          .read<SendNotificationViewModel>()
                          .send(
                            _fileList[0]!,
                            _titleController.text,
                            _contentController.text,
                          )
                          .then(
                            (value) => Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) => const BusinessHomeView(),
                              ),
                              (route) => false,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 10),
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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(1),
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.file(
                File(_fileList.first!.path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 1,
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
            const Radius.circular(10),
          ),
          color: Colors.grey[800],
        ),
        width: double.infinity,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          padding: const EdgeInsets.all(14),
          dashPattern: [3, 3, 3, 3],
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.photo),
              const SizedBox(width: 10),
              const Text(
                'Выберите картинку',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
