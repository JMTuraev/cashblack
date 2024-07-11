import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/owner/business_profile.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_settings_view_model.dart';
import '../../../view_models/business/business_statistics_view_model.dart';
import '../../../view_models/business/business_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../widgets/show_modal.dart';
import '../../../widgets/text_field_widget.dart';
import '../../select_type_view/select_type_view.dart';

class EditNameView extends StatefulWidget {
  EditNameView({
    super.key,
    required this.user,
  });

  final BusinessProfile user;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  State<EditNameView> createState() => _EditNameViewState();
}

class _EditNameViewState extends State<EditNameView> {
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
                    isLoading:
                        context.watch<BusinessSettingsViewModel>().isEditing,
                    text: 'OK',
                    method: () async {
                      await context
                          .read<BusinessSettingsViewModel>()
                          .editOwnerProfile(
                            widget.firstNameController.text,
                            widget.lastNameController.text,
                            widget.user.phone,
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
                  TextButton(
                    // onPressed: Helpers.toMail,
                    onPressed: () async {
                      await showModal(context, [
                        const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Удалить аккаунт?',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        MainButtonWidget(
                          color: Colors.blue,
                          text: 'Отмена',
                          method: () async {
                            Navigator.pop(context);
                          },
                          isLoading: false,
                        ),
                        const SizedBox(height: 10),
                        MainButtonWidget(
                          isLoading: context
                              .watch<BusinessSettingsViewModel>()
                              .isDeleting,
                          color: Colors.red,
                          text: 'Удалить',
                          method: () async {
                            final res = await context
                                .read<BusinessSettingsViewModel>()
                                .deleteBusinessProfile();
                            if (res) {
                              context
                                  .read<BusinessDashboardViewModel>()
                                  .maxSum = 10;
                              await context
                                  .read<BusinessViewModel>()
                                  .logout()
                                  .then(
                                (value) {
                                  context
                                      .read<BusinessStatisticsViewModel>()
                                      .cashbackAndWithdraws
                                      .clear();

                                  context
                                      .read<BusinessDashboardViewModel>()
                                      .clearData();

                                  return Navigator.of(context)
                                      .pushAndRemoveUntil(
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const SelectTypeView(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                      ]);
                    },
                    child: const Text('Удалить аккаунт'),
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
