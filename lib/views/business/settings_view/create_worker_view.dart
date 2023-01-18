import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../view_models/settings_view_model.dart';
import '../../../widgets/helpers.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';
import '../../../widgets/text_field_widget.dart';
import '../business_home_view/business_home_view.dart';

class CreateWorkerView extends StatelessWidget {
  const CreateWorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
        mask: '+### ## ### ## ##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    TextEditingController fistNameController = TextEditingController();

    return ScreenWrapper(
        child: Form(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            MediumTitleWidget(text: 'Добавить сотрудник'),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: 'Имя',
              controller: fistNameController,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Телефон',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              inputFormatters: [maskFormatter],
              // controller: phoneController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardAppearance: Brightness.dark,
              showCursor: true,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            MainButtonWidget(
              text: 'OK',
              method: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     Helpers.customSnackBar(
                //         'Sotrudnik qo`shiladi, klient emas bu'));

                context.read<SettingsViewModel>().createWorker(
                      maskFormatter.getUnmaskedText(),
                      '1',
                      fistNameController.text,
                      ' ',
                    );
                Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => const BusinessHomeView(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
