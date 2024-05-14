import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/owner/business_profile.dart';
import '../../../utils/helpers.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/text_field_widget.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({
    super.key,
    required this.user,
  });

  final BusinessProfile user;

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Align(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  user.firstName.isEmpty && user.lastName.isEmpty
                      ? const _SimpleTextWidget(
                          title: '',
                        )
                      : _SimpleTextWidget(
                          title: '${user.firstName} ${user.lastName}',
                        ),
                  const SizedBox(height: 40),
                  TextFieldWidget(
                    hintText: 'Имя',
                    controller: firstNameController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    hintText: ' Фамилия',
                    controller: lastNameController,
                  ),
                  const Spacer(),
                  MainButtonWidget(
                    text: 'OK',
                    method: () async {
                      await context
                          .read<BusinessSettingsViewModel>()
                          .editOwnerProfile(
                            firstNameController.text,
                            lastNameController.text,
                            user.phone,
                          )
                          .then((value) {
                        if (value) {
                          context
                              .read<BusinessSettingsViewModel>()
                              .getOwnerProfile();
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const TextButton(
                    onPressed: Helpers.toMail,
                    child: Text('Удалить аккаунт'),
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

class _SimpleTextWidget extends StatelessWidget {
  const _SimpleTextWidget({
    super.key,
    required this.title,
  });

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
