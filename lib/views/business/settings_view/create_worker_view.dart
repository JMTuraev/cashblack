import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/text_field_widget.dart';

class CreateWorkerView extends StatefulWidget {
  const CreateWorkerView({super.key});

  @override
  State<CreateWorkerView> createState() => _CreateWorkerViewState();
}

class _CreateWorkerViewState extends State<CreateWorkerView> {
  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
        mask: '+### ## ### ## ##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    TextEditingController fistNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController nickNameController = TextEditingController();

    String? selectedShop;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Добавить сотрудник'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Container(
            // alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: getH(140)),
                TextField(
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
                    hintText: 'Телефон',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  inputFormatters: [maskFormatter],
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardAppearance: Brightness.dark,
                  showCursor: true,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: getH(20)),
                TextFieldWidget(
                  hintText: 'Nickname',
                  controller: nickNameController,
                ),
                SizedBox(height: getH(20)),
                TextFieldWidget(
                  hintText: 'Имя',
                  controller: fistNameController,
                ),
                SizedBox(height: getH(20)),
                TextFieldWidget(
                  hintText: 'Фамилия',
                  controller: lastNameController,
                ),
                SizedBox(height: getH(20)),
                _SelectCategoryWidget(
                  categoryItems: context
                      .read<BusinessDashboardViewModel>()
                      .businessShops
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
                const Spacer(),
                MainButtonWidget(
                  text: 'OK',
                  method: () async {
                    await context
                        .read<BusinessSettingsViewModel>()
                        .createSeller(
                            maskFormatter.getUnmaskedText().substring(3),
                            nickNameController.text,
                            fistNameController.text,
                            lastNameController.text,
                            '44',
                            selectedShop!)
                        .then((value) {
                      if (value) {
                        context.read<BusinessSettingsViewModel>().getWorkers();
                        Navigator.pop(context);
                      } else {
                        print('xato');
                      }
                    });
                  },
                ),
                SizedBox(height: getH(20)),
              ],
            ),
          ),
        ),
      ),
    ));
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
