import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../string_extensions.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_payment_view_model.dart';
import '../../../view_models/payment_client_view_model.dart';
import '../../../widgets/main_button_widget.dart';
import 'payment_success_view.dart';

class PaymentPhoneView extends StatelessWidget {
  PaymentPhoneView({
    super.key,
    required this.shopId,
  });

  final int shopId;

  final _formKey = GlobalKey<FormState>();

  String? selectedShop;

  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: '+998');

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  NumericTextFormatter numericTextFormatter = NumericTextFormatter();

  @override
  Widget build(BuildContext context) {
    // bool isLoading = context.watch<PaymentClientViewModel>().isLoading;
    if (phoneController.text.length < 3) {
      phoneController.text = '+998';
    }

    void submit() async {
      // print(phoneController.text.phoneFormatterForCall().removeForPhone());
      // print(maskFormatter.getUnmaskedText());
      // return;
      if (_formKey.currentState!.validate()) {
        await context
            .read<BusinessPaymentViewModel>()
            .payCashback(
              selectedShop.toString(),
              // maskFormatter.getUnmaskedText(),
              phoneController.text.phoneFormatterForCall().removeForPhone(),
              priceController.text,
            )
            .then((value) {
          if (value) {
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const PaymentSuccessView(
                  title: 'Оплачено',
                ),
              ),
              (route) => false,
            );
          }
        });
        // await context.read<PaymentClientViewModel>().payPhone(
        //     context,
        //     priceController.text.removeWhitespaces(),
        //     maskFormatter.getUnmaskedText(),
        //     shopId);
        // isLoading = true;
        // await context
        //     .read<PaymentClientViewModel>()
        //     .sendCashbackWithPhone(
        //       priceController.text.removeWhitespaces(),
        //       maskFormatter.getUnmaskedText(),
        //       shopId,
        //     )
        //     .then(
        //   (value) {
        //     isLoading = false;
        //     return Navigator.of(context).pushAndRemoveUntil(
        //       CupertinoPageRoute(
        //         builder: (context) => const PaymentSuccessView(
        //           title: 'Оплачено',
        //         ),
        //       ),
        //       (route) => false,
        //     );
        //   },
        // );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата по номеру'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cc.png',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.width / 2.5,
                    ),
                    const SizedBox(height: 20),
                    SelectCategoryWidget(
                      categoryItems: context
                          .read<BusinessDashboardViewModel>()
                          .businessShops!
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
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value.removeWhitespace()) <= 0) {
                          return 'Введите номер телефона';
                        }
                        return null;
                      },
                      controller: phoneController,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: false,
                        hintText: "+998",
                      ),
                      inputFormatters: [maskFormatter],
                      autocorrect: false,
                      // autofocus: true,
                      enableSuggestions: false,
                      keyboardAppearance: Brightness.dark,
                      showCursor: true,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value.removeWhitespace()) <= 0) {
                          return 'Введите сумму';
                        }
                        return null;
                      },
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
                        hintText: 'Сумма покупки',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      controller: priceController,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardAppearance: Brightness.dark,
                      showCursor: true,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    MainButtonWidget(
                      isLoading: false,
                      text: 'Оплатит',
                      method: submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({
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
