import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../string_extensions.dart';
import '../../../utils/numberic_text_formatter.dart';
import '../../../view_models/business/business_dashboard_view_model.dart';
import '../../../view_models/business/business_payment_view_model.dart';
import '../../../view_models/seller/seller_view_model.dart';
import '../../../widgets/logo_animated_widget.dart';
import '../../../widgets/main_button_widget.dart';
import '../../seller/seller_payment_success_view.dart';
import 'payment_phone_view.dart';

class PaymentClientViewForSeller extends StatefulWidget {
  const PaymentClientViewForSeller({
    super.key,
    required this.code,
    required this.shopId,
    required this.isSeller,
  });

  final String code;
  final int shopId;
  final bool isSeller;

  @override
  State<PaymentClientViewForSeller> createState() =>
      _PaymentClientViewForSellerState();
}

class _PaymentClientViewForSellerState
    extends State<PaymentClientViewForSeller> {
  // late final Future<ClientProfile> profile;
  @override
  void initState() {
    // profile = context
    //     .read<PaymentClientViewForSellerModel>()
    //     .getUserFromBarcode(widget.code, widget.shopId);
    context
        .read<BusinessPaymentViewModel>()
        .getCashbackAmountBeforePayForSeller(widget.code);
    super.initState();
  }

  TextEditingController priceController = TextEditingController();

  NumericTextFormatter numericTextFormatter = NumericTextFormatter();

  final _formKey = GlobalKey<FormState>();

  bool isWithdraw = false;

  String percent = '';

  String? selectedShop;
  int cashbackPercentage = 0;

  bool isLoading = false;
  bool isSmallLoading = false;

  @override
  Widget build(BuildContext context) {
    final remainSumma = double.parse(
      (context.read<BusinessPaymentViewModel>().clientProfile?.amount ?? '0')
          .replaceAll(',', ''),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оплата через QR'),
        // bottom: ThemeDetails.appBarDivider,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: context.watch<BusinessPaymentViewModel>().isCheckProfileLoading
              ? const Center(
                  child: LogoAnimatedWidget(size: 1.5),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          // 'fullname',
                          '${context.read<BusinessPaymentViewModel>().clientProfile?.firstName ?? ''} ${context.read<BusinessPaymentViewModel>().clientProfile?.lastName ?? ''}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context
                              .read<BusinessPaymentViewModel>()
                              .clientProfile!
                              .phone
                              .phoneFormatter(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Все кэшбеки ${remainSumma.toString().getFormattedNumber()} сум',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                !widget.isSeller
                                    ? SelectCategoryWidget(
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
                                      )
                                    : const SizedBox(),
                                SizedBox(height: widget.isSeller ? 0 : 20),
                                TextFormField(
                                  maxLength: 12,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      if (value.isEmpty) {
                                        percent = '';
                                      } else {
                                        final a = double.parse(
                                              value.removeWhitespace(),
                                            ) /
                                            100 *
                                            cashbackPercentage;
                                        percent = a.toStringAsFixed(0);
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    // print('val ' + value.toString());
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.parse(value.removeWhitespace()) <=
                                            0) {
                                      print('Введите сумму');
                                      return 'Введите сумму';
                                    } else if (int.parse(
                                              value.removeWhitespace(),
                                            ) >
                                            // user.cashback!.toInt()
                                            remainSumma &&
                                        isWithdraw) {
                                      return 'Введите сумму меньше кэшбека';
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
                                    counterText: '',
                                    hintText: 'Сумма покупки',
                                    labelText: 'Сумма покупки',
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
                                Column(
                                  children: [
                                    Container(
                                      // flex: 2,
                                      child: MainButtonWidget(
                                        isLoading: isLoading,
                                        percent: percent.isEmpty
                                            ? null
                                            : int.parse(percent),
                                        text: 'Выдать кэшбек',
                                        method: () async {
                                          isWithdraw = false;
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print(isWithdraw);

                                            // await context
                                            //     .read<
                                            //         BusinessPaymentViewModel>()
                                            //     .setShopBeforeCashbackOrWithdraw(
                                            //       widget.isSeller
                                            //           ? context
                                            //               .read<
                                            //                   SellerViewModel>()
                                            //               .sellerProfile!
                                            //               .shop
                                            //               .id
                                            //               .toString()
                                            //           : selectedShop.toString(),
                                            //     )
                                            //     .then((value) async {
                                            //   if (value) {}
                                            // });

                                            await context
                                                .read<SellerViewModel>()
                                                .payCashback(
                                                  // widget.isSeller
                                                  //     ? widget.shopId.toString()
                                                  //     : selectedShop.toString(),
                                                  // maskFormatter.getUnmaskedText(),
                                                  // phoneController.text.phoneFormatterForCall().removeForPhone(),
                                                  widget.code
                                                      .removeWhitespace()
                                                      .removeForPhone(),
                                                  priceController.text,
                                                )
                                                .then((value) {
                                              if (value) {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const SellerPaymentSuccessView(
                                                      title: 'Оплачено',
                                                    ),
                                                  ),
                                                  (route) => false,
                                                );
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      child: MainButtonWidget(
                                        color: const Color.fromRGBO(
                                          255,
                                          144,
                                          62,
                                          1,
                                        ),
                                        isLoading: isSmallLoading,
                                        text: 'Использовать кэшбекs',
                                        method: () async {
                                          isWithdraw = true;
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // return true;
                                            await context
                                                .read<
                                                    BusinessPaymentViewModel>()
                                                .payWithdrawForSeller(
                                                  // widget.isSeller
                                                  //     ? widget.shopId.toString()
                                                  //     : selectedShop.toString(),
                                                  // maskFormatter.getUnmaskedText(),
                                                  // phoneController.text.phoneFormatterForCall().removeForPhone(),
                                                  widget.code
                                                      .removeWhitespace()
                                                      .removeForPhone(),
                                                  priceController.text,
                                                )
                                                .then((value) {
                                              if (value) {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const SellerPaymentSuccessView(
                                                      title: 'Оплачено',
                                                    ),
                                                  ),
                                                  (route) => false,
                                                );
                                              }
                                            });
                                            // await context
                                            //     .read<
                                            //         PaymentClientViewForSellerModel>()
                                            //     .payForGoods(
                                            //       context,
                                            //       priceController.text
                                            //           .removeWhitespaces(),
                                            //       widget.code,
                                            //       widget.shopId,
                                            //     );
                                            // .then(
                                            //   (value) =>
                                            //       Navigator.of(context)
                                            //           .pushAndRemoveUntil(
                                            //     CupertinoPageRoute(
                                            //       builder: (context) =>
                                            //           const PaymentSuccessView(
                                            //         title: 'Оплачено',
                                            //       ),
                                            //     ),
                                            //     (route) => false,
                                            //   ),
                                            // );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
