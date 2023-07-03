import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/category.dart';
// import '../../../domain/models/city.dart';
import '../../../string_extensions.dart';
import '../../../size_config.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../view_models/create_store_view_view_model.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/main_button_widget.dart';
import 'business_view.dart';

class CreateCompanyView extends StatefulWidget {
  const CreateCompanyView({super.key});

  @override
  State<CreateCompanyView> createState() => _CreateCompanyViewState();
}

class _CreateCompanyViewState extends State<CreateCompanyView> {
  String? _selectedCategory;
  String? _selectedProvince;
  String? _selectedCity;

  Future<List<Category>>? categoryItems;
  // Future<List<Province>>? provinceItems;
  // Future<List<City>>? cityItems;

  bool _isChecked = false;

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

  void _cropImage(String filepath) async {
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

  onCategoryChanged(String value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  onProvinceChanged(String value) {
    setState(() {
      _selectedCity = null;
      _selectedProvince = value;
      // cityItems = context
      //     .read<CreateCompanyViewViewModel>()
      //     .getCities(_selectedProvince!);
    });
  }

  onCityChanged(String value) {
    setState(() {
      _selectedCity = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    setState(() {});
  }

  Future<void> loadUser() async {
    // categoryItems = context.read<CreateCompanyViewViewModel>().getCategories();
    // provinceItems = context.read<CreateCompanyViewViewModel>().getProvincies();
    // cityItems = context.read<CreateCompanyViewViewModel>().getCities('1');
  }

  final TextEditingController _brandName = TextEditingController();
  final TextEditingController _passport = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _inn = TextEditingController();
  final TextEditingController _pinfl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Future<List<Category>> categoryItems =
    //     context.read<CreateCompanyViewViewModel>().getCategories();
    // Future<List<Province>> provinceItems =
    //     context.read<CreateCompanyViewViewModel>().getProvincies();
    // Future<List<City>> cityItems =
    //     context.read<CreateCompanyViewViewModel>().getCities('1');
    // FlutterNativeSplash.remove();

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
                  // const SizedBox(height: 40),
                  const HeroTitleWidget(text: 'Создать компанию'),
                  // const SizedBox(height: 20),
                  // _fileList.isEmpty
                  //     ? _FilePickerWidget(onTap: getFromGallery)
                  //     : _ImageViewWidget(
                  //         fileList: _fileList,
                  //         onDelete: () {
                  //           clearImages();
                  //         },
                  //         onEdit: () {
                  //           getFromGallery();
                  //         },
                  //       ),
                  // const SizedBox(height: 20),
                  // FutureBuilder(
                  //   future: categoryItems,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       var category = snapshot.data as List<Category>;
                  //       return _SelectCategoryWidget(
                  //         hint: 'Категория',
                  //         selectedOption: _selectedCategory,
                  //         categoryItems: category
                  //             .map(
                  //               (e) => DropdownMenuItem<String>(
                  //                 value: e.id.toString(),
                  //                 child: Text(e.title),
                  //               ),
                  //             )
                  //             .toList(),
                  //         onChanged: onCategoryChanged,
                  //       );
                  //     } else {
                  //       return const _DefaultSelectCategoryWidget(
                  //         hint: 'Категория',
                  //       );
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 20),
                  // _BrandNameWidget(controller: _brandName),

                  _GenericTextFieldWidget(
                    controller: _brandName,
                    title: 'Название',
                  ),
                  // const SizedBox(height: 20),
                  // _SelectCategoryWidget(
                  //   hint: 'Категория',
                  //   selectedOption: _selectedCategory,
                  //   categoryItems:
                  //       context.read<BusinessViewModel>().isLoadingCategories
                  //           ? []
                  //           : context
                  //               .read<BusinessViewModel>()
                  //               .categories
                  //               .map(
                  //                 (e) => DropdownMenuItem<String>(
                  //                   value: e.id.toString(),
                  //                   child: Text(e.title),
                  //                 ),
                  //               )
                  //               .toList(),
                  //   onChanged: onCategoryChanged,
                  // ),
                  // const SizedBox(height: 20),
                  // _CashbackWidget(controller: _cashback),
                  // const SizedBox(height: 20),
                  // FutureBuilder(
                  //   future: provinceItems,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       var provincy = snapshot.data as List<Province>;
                  //       return _SelectCategoryWidget(
                  //         hint: 'Область',
                  //         selectedOption: _selectedProvince,
                  //         categoryItems: provincy
                  //             .map(
                  //               (e) => DropdownMenuItem<String>(
                  //                 value: e.id.toString(),
                  //                 child: Text(e.name),
                  //               ),
                  //             )
                  //             .toList(),
                  //         onChanged: onProvinceChanged,
                  //       );
                  //     } else {
                  //       return const _DefaultSelectCategoryWidget(
                  //         hint: 'Область',
                  //       );
                  //     }
                  //   },
                  // ),
                  // const SizedBox(height: 20),
                  // FutureBuilder(
                  //   future: cityItems,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       var city = snapshot.data as List<City>;
                  //       return _SelectCategoryWidget(
                  //         hint: 'Город',
                  //         selectedOption: _selectedCity,
                  //         categoryItems: city
                  //             .map(
                  //               (e) => DropdownMenuItem<String>(
                  //                 value: e.id.toString(),
                  //                 child: Text(e.name),
                  //               ),
                  //             )
                  //             .toList(),
                  //         onChanged: onCityChanged,
                  //       );
                  //     } else {
                  //       return const _DefaultSelectCategoryWidget(
                  //         hint: 'Город',
                  //       );
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: 20),
                  _GenericTextFieldWidget(
                    controller: _address,
                    title: 'Адрес',
                  ),
                  const SizedBox(height: 20),
                  _GenericTextFieldWidget(
                    controller: _passport,
                    title: 'Паспорт серия',
                    maxlength: 9,
                  ),
                  const SizedBox(height: 20),
                  _NumberTextFieldWidget(
                    controller: _inn,
                    title: 'ИНН',
                    maxLength: 9,
                  ),
                  const SizedBox(height: 20),
                  _NumberTextFieldWidget(
                    controller: _pinfl,
                    title: 'ПИГФЛ',
                    maxLength: 13,
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
                    isLoading: false,
                    method: () async {
                      if (_isChecked
                          //  && _fileList.isNotEmpty
                          ) {
                        // context
                        //     .read<CreateCompanyViewViewModel>()
                        //     .createstore(
                        //       int.parse(_selectedCategory!),
                        //       _brandName.text,
                        //       int.parse(_cashback.text.removeWhitespaces()),
                        //       int.parse(_selectedProvince!),
                        //       int.parse(_selectedCity!),
                        //       _fileList[0]!,
                        //     )
                        //     .then(
                        //       (value) =>
                        //           Navigator.of(context).pushAndRemoveUntil(
                        //               CupertinoPageRoute(
                        //                 builder: (context) =>
                        //                     const BusinessView(),
                        //               ),
                        //               (route) => false),
                        //     );
                        context
                            .read<BusinessDashboardViewModel>()
                            .createBusinessCompany(
                                _brandName.text,
                                _address.text,
                                _passport.text.substring(0, 2),
                                _passport.text.substring(2),
                                _inn.text,
                                _pinfl.text,
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

class _NumberTextFieldWidget extends StatelessWidget {
  const _NumberTextFieldWidget({
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
    // NumericTextFormatter numericTextFormatter = NumericTextFormatter();

    return TextFormField(
      controller: controller,
      // inputFormatters: [numericTextFormatter],
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

class _GenericTextFieldWidget extends StatelessWidget {
  const _GenericTextFieldWidget({
    Key? key,
    required this.controller,
    required this.title,
    this.maxlength,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final int? maxlength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        hintText: title,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        counterText: '',
      ),
      maxLength: maxlength,
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
