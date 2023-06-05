import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user.dart';
import '../../../view_models/client_home_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../client_view.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Align(
              alignment: Alignment.center,
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
                    hintText: 'Фамилия',
                    controller: lastNameController,
                  ),
                  Spacer(),
                  MainButtonWidget(
                    text: 'OK',
                    method: () async {
                      // await context
                      //     .read<ClientHomeViewModel>()
                      //     .changeName(
                      //       user.id,
                      //       firstNameController.text,
                      //       lastNameController.text,
                      //     )
                      //     .then(
                      //       (value) => Navigator.of(context).pushAndRemoveUntil(
                      //         CupertinoPageRoute(
                      //           builder: (context) => const ClientHomeView(),
                      //         ),
                      //         (route) => false,
                      //       ),
                      //     );
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
