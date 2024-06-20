import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/category.dart';
import '../../../domain/models/owner/business_shop.dart';
import '../../../size_config.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/image_view_widget.dart';
import '../../../widgets/main_button_widget.dart';

class EditStoreView extends StatefulWidget {
  const EditStoreView({
    super.key,
    required this.shop,
  });

  final BusinessShop shop;

  @override
  State<EditStoreView> createState() => _EditStoreViewState();
}

class _EditStoreViewState extends State<EditStoreView> {
  String? _selectedCategory;
  String? _selectedProvince;
  String? _selectedCity;

  Future<List<Category>>? categoryItems;

  void onCategoryChanged(String? value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  Future<void> getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (pickedFile != null) {
      await context
          .read<BusinessSettingsViewModel>()
          .uploadShopAvatar(File(pickedFile.path), widget.shop.id)
          .then((value) {
        if (value) {
          context.read<BusinessDashboardViewModel>().getBusinessShops();
          Navigator.pop(context);
        }
      });
    }
  }

  final TextEditingController _brandName = TextEditingController();
  final TextEditingController _waymark = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _cashback = TextEditingController();

  @override
  void initState() {
    super.initState();
    _brandName.text = widget.shop.name;
    _waymark.text = widget.shop.waymark;
    _address.text = widget.shop.address;
    _cashback.text = double.parse(widget.shop.percent).toInt().toString();
    _selectedCategory = widget.shop.categoryShopId.toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeroTitleWidget(text: 'Изменить магазин'),
                  const SizedBox(height: 20),
                  ImageViewWidget(
                    onTap: getFromGallery,
                    imageUrl: widget.shop.logo ?? '',
                  ),
                  const SizedBox(height: 20),
                  _BrandNameWidget(controller: _brandName),
                  const SizedBox(height: 20),
                  _SelectCategoryWidget(
                    hint: 'Категория',
                    selectedOption: _selectedCategory,
                    categoryItems:
                        context.read<BusinessViewModel>().isLoadingCategories
                            ? []
                            : context
                                .read<BusinessViewModel>()
                                .categories
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.id.toString(),
                                    child: Text(e.title),
                                  ),
                                )
                                .toList(),
                    // onChanged: () {}
                    onChanged: onCategoryChanged,
                  ),
                  const SizedBox(height: 20),
                  _CashbackWidget(controller: _cashback),
                  const SizedBox(height: 20),
                  _AddressNameWidget(controller: _address),
                  const SizedBox(height: 20),
                  _WaymarkNameWidget(controller: _waymark),
                  const SizedBox(height: 20),
                  MainButtonWidget(
                    text: 'OK',
                    isLoading: false,
                    method: () async {
                      await context
                          .read<BusinessDashboardViewModel>()
                          .editLocalStore(
                            widget.shop.id,
                            _brandName.text,
                            _cashback.text,
                            _waymark.text,
                            int.parse(_selectedCategory!),
                            '44',
                            _address.text,
                          )
                          .then((value) {
                        if (value) {
                          context
                              .read<BusinessDashboardViewModel>()
                              .getBusinessShops();
                          Navigator.pop(context);
                        } else {
                          print('xato');
                        }
                      });
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

class _CashbackWidget extends StatelessWidget {
  const _CashbackWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final numericTextFormatter = NumericTextFormatter();

    return TextFormField(
      controller: controller,
      inputFormatters: [numericTextFormatter],
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
        counterText: '',
        hintText: 'Кэшбек',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      maxLength: 2,
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
    super.key,
    required List<File?> fileList,
    required this.onDelete,
    required this.onEdit,
  }) : _fileList = fileList;

  final List<File?> _fileList;
  final Function() onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          SizedBox(
            child: GestureDetector(
              onTap: onEdit,
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
              onTap: onDelete,
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
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xff1c1c1d),
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

class _BrandNameWidget extends StatelessWidget {
  const _BrandNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        hintText: 'Бренд',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: TextInputType.text,
    );
  }
}

class _WaymarkNameWidget extends StatelessWidget {
  const _WaymarkNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        hintText: 'Ориентир',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: TextInputType.text,
    );
  }
}

class _AddressNameWidget extends StatelessWidget {
  const _AddressNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        hintText: 'Адрес',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: TextInputType.text,
    );
  }
}

class _SelectCategoryWidget extends StatelessWidget {
  final String? selectedOption;
  final List<DropdownMenuItem<String>> categoryItems;
  final Function(String?)? onChanged;
  final String hint;

  const _SelectCategoryWidget({
    super.key,
    this.selectedOption,
    required this.categoryItems,
    required this.onChanged,
    required this.hint,
  });

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
          value: selectedOption,
          items: categoryItems,
          // onChanged: (v) {},
          onChanged: onChanged,
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
    super.key,
    required this.hint,
  });

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
