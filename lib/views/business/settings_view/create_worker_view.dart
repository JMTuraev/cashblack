import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import '../../../view_models/business_home_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/text_field_widget.dart';

class CreateWorkerView extends StatelessWidget {
  const CreateWorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
        mask: '+### ## ### ## ##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    TextEditingController fistNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Добавить сотрудник'),
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
                    hintText: 'Телефон',
                    border: const OutlineInputBorder(
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
                  hintText: 'Имя',
                  controller: fistNameController,
                ),
                SizedBox(height: getH(20)),
                TextFieldWidget(
                  hintText: 'Фамилия',
                  controller: lastNameController,
                ),
                Spacer(),
                MainButtonWidget(
                  text: 'OK',
                  method: () async {
                    context
                        .read<BusinessHomeViewModel>()
                        .createWorker(
                          maskFormatter.getUnmaskedText(),
                          '1',
                          fistNameController.text,
                          lastNameController.text,
                        )
                        .then(((value) => Navigator.pop(context)));
                    // (value) => Navigator.of(context).pushAndRemoveUntil(
                    //   CupertinoPageRoute(
                    //     builder: (context) => const BusinessHomeView(),
                    //   ),
                    //   (route) => false,
                    // ),
                    // );
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
