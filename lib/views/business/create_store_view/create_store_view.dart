import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_statistics_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../view_models/create_store_view_view_model.dart';
import '../../../widgets/hero_title_widget.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/public_offer_widget.dart';
import '../business_view.dart';

class CreateStoreView extends StatefulWidget {
  const CreateStoreView({super.key});

  @override
  State<CreateStoreView> createState() => _CreateStoreViewState();
}

class _CreateStoreViewState extends State<CreateStoreView> {
  String? _selectedCategory;
  String? _selectedProvince;
  String? _selectedCity;

  Future<List<Category>>? categoryItems;
  // Future<List<Province>>? provinceItems;
  // Future<List<City>>? cityItems;

  bool _isChecked = false;

  // final ImagePicker _picker = ImagePicker();
  // final List<File?> _fileList = [];

  // void getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 1080,
  //     maxWidth: 1080,
  //     // imageQuality: 75,
  //   );
  //   _cropImage(pickedFile!.path);
  // }

  // void _cropImage(String filepath) async {
  //   clearImages();
  //   var croppedImage = await ImageCropper.platform.cropImage(
  //     sourcePath: filepath,
  //     maxHeight: 1080,
  //     maxWidth: 1080,
  //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //     cropStyle: CropStyle.circle,
  //     uiSettings: <PlatformUiSettings>[],
  //   );
  //   if (croppedImage != null) {
  //     setState(() {
  //       _fileList.add(File(croppedImage.path));
  //     });
  //   }
  // }

  // void dltImages(data) {
  //   setState(() {
  //     _fileList.remove(data);
  //   });
  // }

  // void clearImages() {
  //   setState(() {
  //     _fileList.clear();
  //   });
  // }

  // void selectImage() async {
  //   final XFile? image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   setState(() {
  //     File? file = File(image!.path);
  //     _fileList.add(file);
  //   });
  // }

  onCategoryChanged(String value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  // onProvinceChanged(String value) {
  //   setState(() {
  //     _selectedCity = null;
  //     _selectedProvince = value;
  //     // cityItems = context
  //     //     .read<CreateStoreViewViewModel>()
  //     //     .getCities(_selectedProvince!);
  //   });
  // }

  // onCityChanged(String value) {
  //   setState(() {
  //     _selectedCity = value;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    loadUser();
     
  }

  Future<void> loadUser() async {
    // categoryItems = context.read<CreateStoreViewViewModel>().getCategories();
    // provinceItems = context.read<CreateStoreViewViewModel>().getProvincies();
    // cityItems = context.read<CreateStoreViewViewModel>().getCities('1');
   await  context
            .read<BusinessViewModel>()
            .getCategories(); 
    setState(() {});
  }

  final TextEditingController _brandName = TextEditingController();
  final TextEditingController _waymark = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _cashback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Future<List<Category>> categoryItems =
    //     context.read<CreateStoreViewViewModel>().getCategories();
    // Future<List<Province>> provinceItems =
    //     context.read<CreateStoreViewViewModel>().getProvincies();
    // Future<List<City>> cityItems =
    //     context.read<CreateStoreViewViewModel>().getCities('1');
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
                  const HeroTitleWidget(text: 'Создать магазин'),
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
                    onChanged: onCategoryChanged,
                  ),
                  const SizedBox(height: 20),
                  _CashbackWidget(controller: _cashback),
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
                  _AddressNameWidget(controller: _address),
                  const SizedBox(height: 20),
                  _WaymarkNameWidget(controller: _waymark),
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
                        'Я принимаю',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const PublicOfferWidget(fontSize: 16,),
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
                          //     .read<CreateStoreViewViewModel>()
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
                              .createLocalStore(
                                  _brandName.text,
                                  _cashback.text,
                                  _waymark.text,
                                  int.parse(_selectedCategory!),
                                  '44',
                                  _address.text)
                              .then((value) {
                            if (value) {
                              context
                                  .read<BusinessDashboardViewModel>()
                                  .getBusinessShops().then((value) {
                                    context
                .read<BusinessSettingsViewModel>()
                .getWorkers(); // shop yoki magazin bo'lmasa call qilmasin, xatosi bor
            // context
            //     .read<BusinessViewModel>()
            //     .getCategories(); // firma tuzishda kategoriya
            context.read<BusinessStatisticsViewModel>().getStats(); //stat
            context
                .read<BusinessStatisticsViewModel>()
                .getClients(); //clientlar
                                  });
                              Navigator.pop(context);
                            } else {
                              print('xato');
                            }
                          });
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
              Radius.circular(20),
            ),
          ),
          counterText: '',
          hintText: 'Кэшбек',
          labelText: 'Кэшбек',
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
            Radius.circular(20),
          ),
        ),
        hintText: 'Бренд',
        labelText: 'Бренд',
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
            Radius.circular(20),
          ),
        ),
        hintText: 'Ориентир',
        labelText: 'Ориентир',
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
            Radius.circular(20),
          ),
        ),
        hintText: 'Адрес',
        labelText: 'Адрес',
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
          menuMaxHeight: SizeConfig.screenHeight / 2,
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
