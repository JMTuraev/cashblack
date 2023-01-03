import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user.dart';
import '../../../view_models/settings_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/medium_title_widget.dart';
import '../../../widgets/screen_wrapper.dart';
import '../../../widgets/text_field_widget.dart';
import '../business_home_view/business_home_view.dart';
import '../main_view/main_view.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    // MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    //     mask: '+### ## ### ## ##',
    //     filter: {"#": RegExp(r'[0-9]')},
    //     type: MaskAutoCompletionType.lazy);

    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    return ScreenWrapper(
        child: Form(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const MediumTitleWidget(text: 'Редактировать профиль'),
            const SizedBox(height: 20),
            user.firstName.isEmpty && user.lastName.isEmpty
                ? const _SimpleTextWidget(
                    title: '',
                  )
                : _SimpleTextWidget(
                    title: '${user.firstName} ${user.lastName}',
                  ),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: 'Имя',
              controller: firstNameController,
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: ' Фамилия',
              controller: lastNameController,
            ),
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Telefon',
            //     border: const OutlineInputBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(10),
            //       ),
            //     ),
            //   ),
            //   inputFormatters: [maskFormatter],
            //   // controller: phoneController,
            //   autocorrect: false,
            //   enableSuggestions: false,
            //   keyboardAppearance: Brightness.dark,
            //   showCursor: true,
            //   keyboardType: TextInputType.phone,
            // ),
            const SizedBox(height: 20),
            MainButtonWidget(
              text: 'OK',
              method: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     Helpers.customSnackBar('SMS boradi va verify bo`ladi'));
                context.read<SettingsViewModel>().changeName(
                      user.id,
                      firstNameController.text,
                      lastNameController.text,
                    );
                Navigator.pop(context, true);
                // context.read<SettingsViewModel>().rebuild();
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class _SimpleTextWidget extends StatelessWidget {
  const _SimpleTextWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
