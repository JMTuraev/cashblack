import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/category.dart';
import '../../../domain/models/city.dart';
import '../../../domain/models/shop.dart';
import '../../../extensions.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../view_models/create_store_view_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../business_home_view/business_home_view.dart';

class EditStoreView extends StatefulWidget {
  const EditStoreView({
    Key? key,
    required this.shop,
  }) : super(key: key);

  final Shop shop;

  @override
  State<EditStoreView> createState() => _EditStoreViewState();
}

class _EditStoreViewState extends State<EditStoreView> {
  String? _selectedCategory;
  String? _selectedProvince;
  String? _selectedCity;

  Future<List<Category>>? categoryItems;
  Future<List<Province>>? provinceItems;
  Future<List<City>>? cityItems;

  final ImagePicker _picker = ImagePicker();
  final List<File?> _fileList = [];

  void getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
      // imageQuality: 75,
    );
    _cropImage(pickedFile!.path);
  }

  void _cropImage(filepath) async {
    clearImages();
    var croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: filepath,
      maxHeight: 1080,
      maxWidth: 1080,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.circle,
      uiSettings: <PlatformUiSettings>[],
    );
    if (croppedImage != null) {
      setState(() {
        _fileList.add(File(croppedImage.path));
      });
    }
  }

  void dltImages(data) {
    setState(() {
      _fileList.remove(data);
    });
  }

  void clearImages() {
    setState(() {
      _fileList.clear();
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

  onCategoryChanged(value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  onProvinceChanged(value) {
    setState(() {
      _selectedCity = null;
      _selectedProvince = value;
      cityItems = context
          .read<CreateStoreViewViewModel>()
          .getCities(_selectedProvince!);
    });
  }

  onCityChanged(value) {
    setState(() {
      _selectedCity = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    _selectedCity = widget.shop.city.id.toString();
    _selectedProvince = widget.shop.province.id.toString();
    _selectedCategory = widget.shop.category.id.toString();
    setState(() {});
  }

  Future<void> loadUser() async {
    categoryItems = context.read<CreateStoreViewViewModel>().getCategories();
    provinceItems = context.read<CreateStoreViewViewModel>().getProvincies();
    cityItems = context
        .read<CreateStoreViewViewModel>()
        .getCities(widget.shop.province.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _brandName =
        TextEditingController(text: widget.shop.name);
    final TextEditingController _cashback =
        TextEditingController(text: widget.shop.cashback.toString());
    // Future<List<Category>> categoryItems =
    //     context.read<CreateStoreViewViewModel>().getCategories();
    // Future<List<Province>> provinceItems =
    //     context.read<CreateStoreViewViewModel>().getProvincies();
    // Future<List<City>> cityItems =
    //     context.read<CreateStoreViewViewModel>().getCities('1');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Align(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _fileList.isEmpty
                      ? _FilePickerWidget(onTap: getFromGallery)
                      : _ImageViewWidget(
                          fileList: _fileList,
                          onDelete: () {
                            clearImages();
                          },
                          onEdit: () {
                            getFromGallery();
                          },
                        ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: categoryItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var category = snapshot.data as List<Category>;
                        return _SelectCategoryWidget(
                          hint: 'Категория',
                          selectedOption: widget.shop.category.id.toString(),
                          categoryItems: category
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e.id.toString(),
                                  child: Text(e.title),
                                ),
                              )
                              .toList(),
                          onChanged: onCategoryChanged,
                        );
                      } else {
                        return const _DefaultSelectCategoryWidget(
                          hint: 'Категория',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  _BrandNameWidget(controller: _brandName),
                  const SizedBox(height: 20),
                  _CashbackWidget(
                    controller: _cashback,
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: provinceItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var provincy = snapshot.data as List<Province>;
                        return _SelectCategoryWidget(
                          hint: 'Область',
                          // selectedOption: _selectedProvince,
                          selectedOption: provincy
                              .where(
                                (element) =>
                                    element.id == widget.shop.province.id,
                              )
                              .first
                              .id
                              .toString(),
                          categoryItems: provincy
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e.id.toString(),
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: onProvinceChanged,
                        );
                      } else {
                        return const _DefaultSelectCategoryWidget(
                          hint: 'Область',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: cityItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var city = snapshot.data as List<City>;
                        return _SelectCategoryWidget(
                          hint: 'Город',
                          // selectedOption: _selectedCity,
                          selectedOption: city
                              // .where(
                              //   (element) => element.id == widget.shop.city.id,
                              // )
                              .first
                              .id
                              .toString(),
                          categoryItems: city
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e.id.toString(),
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: onCityChanged,
                        );
                      } else {
                        return const _DefaultSelectCategoryWidget(
                          hint: 'Город',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  MainButtonWidget(
                    text: 'OK',
                    method: () async {
                      if (_fileList.isNotEmpty) {
                        context
                            .read<BusinessHomeViewModel>()
                            .editstore(
                              widget.shop.id,
                              int.parse(_selectedCategory!),
                              _brandName.text,
                              int.parse(_cashback.text.removeWhitespaces()),
                              int.parse(_selectedProvince!),
                              int.parse(_selectedCity!),
                              _fileList[0]!,
                            )
                            .then((value) =>
                                //     Navigator.of(context).pushAndRemoveUntil(
                                //   CupertinoPageRoute(
                                //     builder: (context) =>
                                //         const BusinessHomeView(),
                                //   ),
                                //   (route) => false,
                                // ));
                                Navigator.pop(context));
                      } else
                        print('check');
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
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    NumericTextFormatter numericTextFormatter = NumericTextFormatter();

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
            Radius.circular(10),
          ),
        ),
        hintText: 'Кэшбек',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
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
          borderRadius: const BorderRadius.all(
            const Radius.circular(90),
          ),
          color: Colors.grey[800],
        ),
        width: 150,
        height: 150,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(90),
          padding: const EdgeInsets.all(14),
          dashPattern: const [3, 3, 3, 3],
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Icon(
                  CupertinoIcons.photo,
                  size: 40,
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
    Key? key,
    required this.controller,
  }) : super(key: key);

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
            Radius.circular(10),
          ),
        ),
        hintText: 'Бренд',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
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
            Radius.circular(10),
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
                Radius.circular(10),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
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
            Radius.circular(10),
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
                Radius.circular(10),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
