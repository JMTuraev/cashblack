import 'package:flutter/material.dart';

import '../../../../size_config.dart';
import '../../../../widgets/main_button_widget.dart';
import '../../../../widgets/show_modal.dart';
import '../../../../widgets/text_field_with_label_widget.dart';
import '../../../../widgets/text_field_with_phone_widget.dart';

class CreateStaffView extends StatelessWidget {
  const CreateStaffView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить участник'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFieldWithLabelWidget(hintText: 'Имя Фамилия'),
              const SizedBox(height: 10),
              TextFieldWithPhoneWidget(hintText: 'Номер телефона'),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  showModal(context, [
                    const Text(
                      'Введите код аутентификации',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter the 4-digit that we have sent via the\nphone number +998 99 123 45 87',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        ...[1, 2, 3, 4, 5, 6].map(
                          (e) => Container(
                            width: getW(50),
                            height: getW(50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(64),
                              border: Border.all(
                                color: const Color(0xff6c7072),
                              ),
                              color: const Color(0xff1c1c1d),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ]);
                },
                child: const Text(
                  'СМС код',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xff34c85a),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Зарплата',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Ежемесячно',
                    style: TextStyle(
                      color: Color(0xff72777a),
                      fontSize: 16,
                    ),
                  ),
                  Switch(value: true, onChanged: (v) {}),
                  const Text(
                    'Ежедневно',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFieldWithLabelWidget(hintText: 'Сумма'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFieldWithLabelWidget(hintText: 'Сум'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        _CustomCheckBox(
                          selections: const [],
                          value: true,
                          onTap: () {},
                        ),
                        const Text(
                          'Бонус от продажа',
                          style: TextStyle(
                            color: Color(0xff72777a),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFieldWithLabelWidget(hintText: '%'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Время',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithLabelWidget(
                      hintText: 'От',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFieldWithLabelWidget(
                      hintText: 'До',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  showModal(context, [
                    const Text(
                      'Dood',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Adminstrator',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      value: false,
                      onChanged: (v) {},
                    ),
                    CheckboxListTile(
                      title: const Text(
                        'Повар',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      value: false,
                      onChanged: (v) {},
                    ),
                    CheckboxListTile(
                      title: const Text(
                        'Официант',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      value: false,
                      onChanged: (v) {},
                    ),
                    CheckboxListTile(
                      title: const Text(
                        'Кассир',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      value: false,
                      onChanged: (v) {},
                    ),
                    CheckboxListTile(
                      title: const Text(
                        'Бухгалтер',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      value: false,
                      onChanged: (v) {},
                    ),
                    MainButtonWidget(
                      isLoading: false,
                      text: 'Применять',
                      method: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Сброс',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ]);
                },
                child: const Text(
                  'Должность',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                height: getW(100),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.asset(
                                'assets/images/notification/ak-3.png',
                                height: getW(70),
                                width: getW(70),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Text(
                              'Dood',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: getW(26),
                            width: getW(26),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: const Color.fromRGBO(107, 78, 255, 0.41),
                            ),
                            child: const Center(child: Text('12')),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              MainButtonWidget(
                isLoading: false,
                text: 'Добавить',
                method: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomCheckBox extends StatelessWidget {
  const _CustomCheckBox({
    super.key,
    required this.selections,
    required this.value,
    required this.onTap,
  });

  final List<int> selections;
  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.green,
        side: const BorderSide(
          color: Colors.green,
          width: 3,
        ),
        overlayColor: MaterialStateProperty.all(Colors.green),
        fillColor: MaterialStateProperty.all(Colors.green),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        value: value,
        onChanged: (value) {
          onTap();
        },
      );
}
