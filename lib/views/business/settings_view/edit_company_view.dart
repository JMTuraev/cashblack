import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/owner/business_company.dart';
import '../../../size_config.dart';
import '../../../string_extensions.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../create_company_view.dart';

class EditCompanyView extends StatefulWidget {
  final BusinessCompany company;

  const EditCompanyView({super.key, required this.company});
  @override
  State<EditCompanyView> createState() => _EditCompanyViewState();
}

class _EditCompanyViewState extends State<EditCompanyView> {
  bool _isChecked = false;

  final TextEditingController _brandName = TextEditingController();
  final TextEditingController _passport = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _inn = TextEditingController();
  final TextEditingController _pinfl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _brandName.text = widget.company.name;
    _passport.text = widget.company.passwordId ?? '';
    _address.text = widget.company.address;
    _inn.text = widget.company.inn;
    _pinfl.text = widget.company.pinfl ?? '';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    inspect(widget.company);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeroTitleWidget(text: 'Изменить компанию'),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: _brandName,
                    hintText: 'Название',
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: _address,
                    hintText: 'Адрес',
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: _passport,
                    hintText: 'Паспорт серия',
                    maxLength: 9,
                    validator: (p0) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: _inn,
                    hintText: 'ИНН',
                    maxLength: 9,
                    skipNumberFormatter: true,
                    textType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: _pinfl,
                    textType: TextInputType.number,
                    hintText: 'ПИНФЛ',
                    maxLength: 13,
                    validator: (p0) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  MainButtonWidget(
                    text: 'OK',
                    isLoading:
                        context.watch<BusinessSettingsViewModel>().isEditing,
                    method: () async {
                      if (_formKey.currentState!.validate()) {
                        await context
                            .read<BusinessSettingsViewModel>()
                            .editBusinessCompany(
                                _brandName.text,
                                _address.text,
                                _passport.text.isEmpty
                                    ? ''
                                    : _passport.text.substring(0, 2),
                                _passport.text.isEmpty
                                    ? ''
                                    : _passport.text.substring(2),
                                _inn.text.removeWhitespace(),
                                _pinfl.text.removeWhitespace(),
                                '44')
                            .then((value) {
                          if (value) {
                            context
                                .read<BusinessDashboardViewModel>()
                                .getBusinessCompany();
                            Navigator.pop(context);
                          } else {
                            print('Ошибка сервера');
                          }
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberTextFieldWidget extends StatelessWidget {
  const NumberTextFieldWidget({
    Key? key,
    required this.controller,
    required this.title,
    required this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        counterText: '',
        hintText: title,
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      maxLength: maxLength,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: TextInputType.number,
    );
  }
}

class _ImageViewWidget extends StatelessWidget {
  const _ImageViewWidget({
    Key? key,
    required List<File?> fileList,
    required this.onDelete,
    required this.onEdit,
  })  : _fileList = fileList,
        super(key: key);

  final List<File?> _fileList;
  final Function onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          SizedBox(
            child: GestureDetector(
              onTap: () => onEdit(),
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                  File(_fileList.first!.path),
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ),
          Positioned(
            right: 1,
            child: GestureDetector(
              onTap: () => onDelete(),
              child: const Icon(Icons.cancel, color: Colors.redAccent),
            ),
          ),
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
          borderRadius: BorderRadius.circular(30),
          color: Color(0xff1c1c1d),
        ),
        width: 120,
        height: 120,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(30),
          dashPattern: const [3, 3, 3, 3],
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svg/gallery.svg',
                  height: 60,
                  width: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectCategoryWidget extends StatelessWidget {
  const _SelectCategoryWidget({
    Key? key,
    required String? selectedOption,
    required this.categoryItems,
    required this.onChanged,
    required this.hint,
  })  : _selectedOption = selectedOption,
        super(key: key);

  final String? _selectedOption;
  final List<DropdownMenuItem<String>> categoryItems;
  final Function onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: DropdownButtonFormField<String>(
          style: const TextStyle(
            fontSize: 16,
          ),
          hint: Text(hint),
          isExpanded: true,
          value: _selectedOption,
          items: categoryItems,
          onChanged: (value) => onChanged(value),
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultSelectCategoryWidget extends StatelessWidget {
  const _DefaultSelectCategoryWidget({
    Key? key,
    required this.hint,
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: DropdownButtonFormField<String>(
          style: const TextStyle(
            fontSize: 16,
          ),
          hint: Text(hint),
          isExpanded: true,
          value: '',
          items: const [],
          onChanged: (_) => {},
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
