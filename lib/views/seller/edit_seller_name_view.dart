import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/main_button_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../domain/models/seller/seller_owner_profile.dart';
import '../../view_models/seller/seller_view_model.dart';

class EditSellerNameView extends StatefulWidget {
  EditSellerNameView({
    super.key,
    required this.user,
  });

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final SellerOwnerProfile user;

  @override
  State<EditSellerNameView> createState() => _EditSellerNameViewState();
}

class _EditSellerNameViewState extends State<EditSellerNameView> {
  @override
  void initState() {
    super.initState();
    widget.firstNameController.text = widget.user.firstName;
    widget.lastNameController.text = widget.user.lastName;
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.user.firstName.isEmpty && widget.user.lastName.isEmpty
                      ? const _SimpleTextWidget(
                          title: '',
                        )
                      : _SimpleTextWidget(
                          title:
                              '${widget.user.firstName} ${widget.user.lastName}',
                        ),
                  const SizedBox(height: 40),
                  TextFieldWidget(
                    hintText: 'Имя',
                    controller: widget.firstNameController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    hintText: ' Фамилия',
                    controller: widget.lastNameController,
                  ),
                  const Spacer(),
                  MainButtonWidget(
                    isLoading: context.watch<SellerViewModel>().isEditing,
                    text: 'OK',
                    method: () async {
                      await context
                          .read<SellerViewModel>()
                          .editSellerProfile(
                            widget.firstNameController.text,
                            widget.lastNameController.text,
                            widget.user.phone,
                          )
                          .then((value) {
                        if (value) {
                          context.read<SellerViewModel>().getSellerProfile();
                          Navigator.pop(context);
                        }
                      });
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
