import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/helpers.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/multiline_text_field_widget.dart';
import '../../../widgets/screen_wrapper.dart';
import '../../../widgets/text_field_widget.dart';

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
    );
    setState(() {
      File? file = File(image!.path);
      _fileList.add(file);
    });
  }

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        child: Form(
      child: Column(
        children: [
          MediumTitleWidget(text: 'Отправка уведомлений'),
          const SizedBox(height: 20),
          TextFieldWidget(hintText: 'Заголовок'),
          const SizedBox(height: 20),
          MultilineTextFieldWidget(hintText: 'Текст'),
          const SizedBox(height: 20),
          _fileList.isEmpty
              ? _FilePickerWidget(onTap: selectImage)
              : _ImageViewWidget(
                  fileList: _fileList,
                  onTap: () {
                    dltImages(_fileList.first);
                  },
                ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
              prefixIcon: Icon(CupertinoIcons.calendar),
              hintText: 'Дата',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _dateController.text.isNotEmpty
                    ? DateTime.parse(_dateController.text)
                    : DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2100),
              );
              if (pickedDate == null) return;
              setState(
                () {
                  _dateController.text = pickedDate.toString();
                },
              );
            },
          ),
          const SizedBox(height: 20),
          MainButtonWidget(
            text: 'Отправить',
            method: () {
              ScaffoldMessenger.of(context).showSnackBar(
                Helpers.customSnackBar('Klientlarga notifcation boradi'),
              );
            },
          ),
        ],
      ),
    ));
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
    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 100,
            width: 100,
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
              ))
        ],
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
                'Select photo',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
