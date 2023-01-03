import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/category.dart';
import '../../../domain/models/city.dart';
import '../../../view_models/create_store_view_view_model.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/main_button_widget.dart';
import '../business_home_view/business_home_view.dart';

class CreateStoreView extends StatefulWidget {
  const CreateStoreView({super.key});

  @override
  State<CreateStoreView> createState() => _CreateStoreViewState();
}

class _CreateStoreViewState extends State<CreateStoreView> {
  String? _selectedCategory;
  String? _selectedProvince;
  String? _selectedCity;

  bool _isChecked = false;

  final ImagePicker _picker = ImagePicker();
  List<File?> _fileList = [];
  // File? _imageFile;

  void getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    // Navigator.pop(context);
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
      //   dltImages(_fileList.first);
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
      _selectedProvince = value;
    });
  }

  onCityChanged(value) {
    setState(() {
      _selectedCity = value;
    });
  }

  TextEditingController _brandName = TextEditingController();
  TextEditingController _cashback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // context.read<CreateStoreViewViewModel>().getCategoryProperties();
    // List<Category> categories =
    //     context.watch<CreateStoreViewViewModel>().categories;
    // List<Province> provincies =
    //     context.watch<CreateStoreViewViewModel>().provincies;
    // List<City> cities = context.watch<CreateStoreViewViewModel>().cities;

    // var categoryItems = categories
    //     .map(
    //       (e) => DropdownMenuItem<String>(
    //         value: e.id.toString(),
    //         child: Text(e.title),
    //       ),
    //     )
    //     .toList();

    Future<List<Category>> categoryItems =
        context.read<CreateStoreViewViewModel>().getCategories();
    Future<List<Province>> provinceItems =
        context.read<CreateStoreViewViewModel>().getProvincies();
    Future<List<City>> cityItems =
        context.read<CreateStoreViewViewModel>().getCities();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const HeroTitleWidget(text: 'Создать'),
                  const SizedBox(height: 20),
                  _fileList.isEmpty
                      ? _FilePickerWidget(onTap: getFromGallery)
                      : _ImageViewWidget(
                          fileList: _fileList,
                          onDelete: () {
                            // dltImages(_fileList.first);
                            clearImages();
                          },
                          onEdit: () {
                            getFromGallery();
                          },
                        ),
                  const SizedBox(height: 20),
                  // _SelectCategoryWidget(
                  //   selectedOption: _selectedCategory,
                  //   categoryItems: categoryItems,
                  //   onChanged: onCategoryChanged,
                  // ),
                  FutureBuilder(
                    future: categoryItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var category = snapshot.data as List<Category>;
                        return _SelectCategoryWidget(
                          hint: 'Select Category',
                          selectedOption: _selectedCategory,
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
                          hint: 'Select Category',
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
                  // _SelectCategoryWidget(
                  //   selectedOption: _selectedProvince,
                  //   categoryItems: provinceItems,
                  //   onChanged: onProvinceChanged,
                  // ),
                  FutureBuilder(
                    future: provinceItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var provincy = snapshot.data as List<Province>;
                        return _SelectCategoryWidget(
                          hint: 'Select province',
                          selectedOption: _selectedProvince,
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
                          hint: 'Select Category',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  // _SelectCategoryWidget(
                  //     selectedOption: _selectedCity,
                  //     categoryItems: cityItems,
                  //     onChanged: onCityChanged),
                  FutureBuilder(
                    future: cityItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var city = snapshot.data as List<City>;
                        return _SelectCategoryWidget(
                          hint: 'Select City',
                          selectedOption: _selectedCity,
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
                          hint: 'Select Category',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: ((value) {
                          setState(() {
                            _isChecked = value!;
                          });
                          print(value);
                        }),
                      ),
                      const Text(
                        'Я принимаю условия оферты',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MainButtonWidget(
                      text: 'OK',
                      method: () {
                        if (_isChecked) {
                          print(
                              '$_selectedCategory  $_selectedProvince $_selectedProvince');
                          context.read<CreateStoreViewViewModel>().createstore(
                              29,
                              int.parse(_selectedCategory!),
                              _brandName.text,
                              double.parse(_cashback.text),
                              int.parse(_selectedProvince!),
                              int.parse(_selectedCity!));
                          Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) => const BusinessHomeView(),
                              ),
                              (route) => false);
                        } else
                          print('check');
                      }),
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
    return TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Cashback',
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
        keyboardType: TextInputType.number);
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
            const Radius.circular(10),
          ),
          color: Colors.grey[800],
        ),
        width: double.infinity,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          padding: const EdgeInsets.all(14),
          dashPattern: const [3, 3, 3, 3],
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(CupertinoIcons.photo),
              SizedBox(width: 10),
              Text(
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
        hintText: 'Brand name',
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
