// import 'package:cn_delivery/helper/appImages.dart';
// import 'package:cn_delivery/helper/appbutton.dart';
// import 'package:cn_delivery/helper/appcolor.dart';
// import 'package:cn_delivery/helper/fontfamily.dart';
// import 'package:cn_delivery/helper/gettext.dart';
// import 'package:cn_delivery/helper/screensize.dart';
// import 'package:cn_delivery/localization/language_constrants.dart';
// import 'package:cn_delivery/provider/wallet_provider.dart';
// import 'package:cn_delivery/utils/time_format.dart';
// import 'package:cn_delivery/utils/utils.dart';
// import 'package:cn_delivery/widget/no_data_found.dart';
// import 'package:cn_delivery/widget/appBar.dart';
// import 'package:cn_delivery/widget/btn_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class WalletScreen extends StatefulWidget {
//   const WalletScreen({super.key});

//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
//   int selectIndex = 0;

//   // List list = ['HDFC', "ICICI"];
//   String? selectedDropDownValue;
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((val) {
//       callInitialFunction();
//     });
//     super.initState();
//   }

//   callInitialFunction() async {
//     final provider = Provider.of<WalletProvider>(context, listen: false);
//     provider.walletEarnApiFunction();
//     // final profileProvider =
//     //     Provider.of<ProfileProvider>(context, listen: false);
//     // if(profileProvider.profileModel==null){
//     //   profileProvider.getProfileApiFunction(false);
//     // }
    
//   }

//   // String generateReference() {
//   //   return 'REF-${DateTime.now().millisecondsSinceEpoch}';
//   // }

//   // Future initalizePaymentMethod() async {
//   //   final profileProvider =
//   //       Provider.of<ProfileProvider>(context, listen: false);
//   //   var model = profileProvider.profileModel!.data!;
//   //   WompiClient wompiClient = WompiClient(
//   //     publicKey: Constants
//   //         .publicPaymentKey, // Business Public Key from Wompi Dashboard
//   //     environment:
//   //         Environment.PRODUCTION, // or Environment.TEST for testing purposes,
//   //     businessPrefix: 'FR-', // Business Prefix
//   //     integrityKey:
//   //         Constants.intergrityKey, // secret integrity key from Wompi Dashboard
//   //     currency: 'COP', // Currency for the payments
//   //   );
//   //   final acceptance =
//   //       await WompiService.getAcceptance(wompiClient: wompiClient);

//   //   final acceptanceToken = acceptance.data.presignedAcceptance.acceptanceToken;
//   //   print("acceptanceToken....$acceptanceToken");
//   //   PaymentRequestData paymentRequestData = PaymentRequestData(
//   //       email: model.email, // The email of the user who will make the payment.
//   //       phone: model.phone, // The phone of the user who will make the payment.
//   //       name:
//   //           "${model.fName ?? ''} ${model.lName ?? ''}", // The name of the user who will make the payment.
//   //       acceptanceToken:
//   //           acceptanceToken, // The token that will be used to make the payment.
//   //       reference: generateReference(), // The reference of the payment.
//   //       document:
//   //           "customer_identification" // The document of the user who will make the payment.
//   //       );
//   //   return [wompiClient, paymentRequestData];
//   // }

//   // creditCardPaymentMethod(
//   //     {required String cardNumber,
//   //     required String cvcCode,
//   //     required String expYear,
//   //     required String expMonth,
//   //     required int amount,
//   //     required String cardHolderName}) async {
//   //   showCircleProgressDialog(context);
//   //   initalizePaymentMethod().then((val) async {
//   //     try {
//   //       CreditCard creditCard = CreditCard(
//   //           cardNumber: cardNumber, // Credit card number
//   //           cvcCode: cvcCode, // CVC code
//   //           expYear: expYear, // Expiration year
//   //           expMonth: expMonth, // Expiration month
//   //           amount: amount, // Amount to pay as integer
//   //           quotas: 12, // Quotas to pay as integer
//   //           cardHolder: cardHolderName // Card holder name
//   //           );

//   //       // Create instance fot Payment
//   //       CreditCardPay creditCardPay = CreditCardPay(
//   //           creditCard: creditCard, // Credit card information
//   //           paymentRequest: val[1], // Payment request data
//   //           wompiClient: val[0] // Wompi client
//   //           );

//   //       // Make the payment with the credit card information.
//   //       final CardPaymentResponse cardPayment =
//   //           await WompiService.pay(paymentProcessor: creditCardPay);

//   //       // Check the response of the payment.
//   //       final CardCheckModel cardCheck = await WompiService.checkPayment(
//   //           paymentChecker: CreditCardCheck(
//   //               transactionId: cardPayment.data.id, wompiClient: val[0]));
//   //       Navigator.pop(context);
//   //       var jsonData = jsonEncode(cardCheck.data);
//   //       print(jsonData);
//   //       if (cardCheck.data.status == 'APPROVED') {
//   //         Navigator.pop(context);
//   //         Provider.of<WalletProvider>(context,listen: false).addAmountApiFunction(amount.toString(), jsonData);
//   //       } else {
//   //         errorDialogBox(cardCheck.data.status, cardCheck.data.statusMessage);
//   //       }
//   //     } catch (e) {
//   //       print(e);
//   //       Navigator.pop(context);
//   //       errorDialogBox('Error', e.toString());
//   //     }
//   //   });
//   // }

// //   nequiPaymentMethod(String number, int amount) async {
// //     try {
// //       showCircleProgressDialog(context);
// //       initalizePaymentMethod().then((val) async {
// //         print(val);
// //         NequiPay nequiPay = NequiPay(
// //             paymentRequest: val[1], // Payment request data
// //             wompiClient: val[0], // Wompi client
// //             amount: amount, // Amount to pay as integer
// //             phoneNumberToPay: number // Phone number to pay
// //             );
// // // "3992222222"
// // //   /// Make the payment with the Nequi information.
// //         final NequiPaymentResponse nequiPayment =
// //             await WompiService.pay(paymentProcessor: nequiPay);

// // //   // Check the response of the payment.
// //         final NequiCheckModel nequiCheck = await WompiService.checkPayment(
// //             paymentChecker: NequiCheck(
// //                 transactionId: nequiPayment.data.id, wompiClient: val[0]));
// //         print(nequiCheck.data.status);
// //         log(json.encode(nequiCheck.data));
// //         Navigator.pop(context);
// //         var jsonData = jsonEncode(nequiCheck.data);
// //         if (nequiCheck.data.status == 'APPROVED') {
// //               Navigator.pop(context);
// //           Provider.of<WalletProvider>(context,listen: false).addAmountApiFunction(amount.toString(), jsonData);
// //         } else {
// //           errorDialogBox(nequiCheck.data.status, nequiCheck.data.statusMessage);
// //         }
// //       });
// //     } catch (e) {
// //       Navigator.pop(context);
// //       errorDialogBox('Error', e.toString());
// //     }
// //   }

//   List bankList = [];

//   // pseBankList() {
//   //   bankList.clear();
//   //   // showCircleProgressDialog(context);
//   //   initalizePaymentMethod().then((val) async {
//   //     // Navigator.pop(context);
//   //     if (val != null) {
//   //       final banks = await WompiService.getBanks(wompiClient: val[0]);
//   //       print("banks...${banks[0].financialInstitutionName}");
//   //       // final selectedBank =
//   //       //     banks.first; // In this case the user select the first Bank.
//   //           bankList = banks;
//   //           setState(() {
//   //           });
//   //           dialogBox(paymentMethodIndex: 3);            
//   //     }
//   //   });
//   // }

//   // psePaymentMethod(
//   //     String bankCode, int amount, wompiClient, paymentRequest) async {
//   //   // Create instance for the PSE Request
//   //   try {
//   //     showCircleProgressDialog(context);
//   //     final pseRequest = PseRequest(
//   //         personType: PersonType.natural, // Person type
//   //         documentType: "CC", // Document type
//   //         amount: amount, // Amount to pay as integer
//   //         bankCode: bankCode, // Bank code
//   //         paymentDescription: "Test Payment" // Payment description
//   //         );
//   //     // selectedBank.financialInstitutionCode
//   //     // Create the payment with the PSE information.
//   //     final psePay = PsePay(
//   //         pseRequest: pseRequest, // PSE request data
//   //         paymentRequest: paymentRequest, // Payment request data
//   //         wompiClient: wompiClient // Wompi client
//   //         );

//   //     // Make the payment with the PSE information.
//   //     final PsePaymentResponse payment =
//   //         await WompiService.pay(paymentProcessor: psePay);

//   //    // You need to redirect the user to the URL provided by the Wompi Service.
//   //     final paymentURL = payment.data.paymentMethod.extra!.asyncPaymentUrl;

//   //    // Then you need to check the PSE payment status.
//   //     final PsePaymentResponse response = await WompiService.checkPayment(
//   //         paymentChecker: PseCheck(
//   //             transactionId: payment.data.id, wompiClient: wompiClient));

//   //     log(json.encode(response.data));
//   //     print(response.data);
//   //     Navigator.pop(context);
//   //     if (response.data.status == 'APPROVED') {
//   //     } else {
//   //       errorDialogBox(response.data.status, response.data.statusMessage);
//   //     }
//   //   } catch (e) {
//   //     Navigator.pop(context);
//   //     errorDialogBox('Error', e.toString());
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.whiteColor,
//       appBar: appBar(
//         title: getTranslated('wallet', context)!,
//       ),
//       body: Consumer<WalletProvider>(builder: (context, myProvider, child) {
//         return Column(
//           children: [
//             availableAmountWidget(myProvider),
//             ScreenSize.height(15),
//             Expanded(child: recentTranscationWidget(myProvider))
//           ],
//         );
//       }),
//     );
//   }

//   availableAmountWidget(WalletProvider provider) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       decoration: BoxDecoration(
//           color: AppColor.whiteColor,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(0, 2),
//                 blurRadius: 8,
//                 color: AppColor.blackColor.withOpacity(.1))
//           ]),
//       padding: const EdgeInsets.only(top: 17, left: 23, right: 17, bottom: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Image.asset(
//                 AppImages.walletIcon,
//                 width: 30,
//                 height: 30,
//               ),
//               ScreenSize.width(16),
//               getText(
//                   title: getTranslated('total_available_amount', context)!,
//                   size: 16,
//                   fontFamily: FontFamily.poppinsRegular,
//                   color: AppColor.blackColor,
//                   fontWeight: FontWeight.w600)
//             ],
//           ),
//           ScreenSize.height(19),
//           getText(
//               title:
//                   '\$ ${provider.model != null && provider.model!.data != null ? provider.model!.data!.currentBalance : "0"}',
//               size: 30,
//               fontFamily: FontFamily.poppinsSemiBold,
//               color: AppColor.blackColor,
//               fontWeight: FontWeight.w700),
//           ScreenSize.height(15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               btn(
//                   title: getTranslated('withdrawal', context)!,
//                   color: AppColor.rejectColor,
//                   width: 100,
//                   onTap: () {
//                     dialogBox();
//                     // Utils.showToast("Comming soon");
//                   }),
//               // btn(
//               //     title: getTranslated('recharge', context)!,
//               //     color: AppColor.appTheme,
//               //     width: 100,
//               //     onTap: () {
//               //       paymentMethodBottomSheet();
//               //     })
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   recentTranscationWidget(WalletProvider provider) {
//     return Container(
//       decoration: BoxDecoration(
//           color: AppColor.whiteColor,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(0, -1),
//                 color: AppColor.blackColor.withOpacity(.1),
//                 blurRadius: 10)
//           ]),
//       padding: const EdgeInsets.only(top: 20, left: 23, right: 17, bottom: 18),
//       child: Column(
//         children: [
//           Center(
//             child: getText(
//                 title: getTranslated('recent_transcation', context)!,
//                 size: 14,
//                 fontFamily: FontFamily.nunitoMedium,
//                 color: AppColor.blackColor,
//                 fontWeight: FontWeight.w500),
//           ),
//           provider.model != null && provider.model!.data != null
//               ? Expanded(
//                   child: provider.model!.data!.transactionHistory!.isNotEmpty
//                       ? ListView.builder(
//                           itemCount:
//                               provider.model!.data!.transactionHistory!.length,
//                           padding: const EdgeInsets.only(top: 15),
//                           shrinkWrap: true,
//                           physics: const ScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return walletTransaction(context, index, provider);
//                           })
//                       : noDataFound(getTranslated('no_transaction_history', context)!),
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }

//   walletTransaction(BuildContext context, int index, WalletProvider provider) {
//     var model = provider.model!.data!.transactionHistory![index];
//     return Padding(
//       padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 6),
//       child: GestureDetector(
//         onTap: () {},
//         child: SizedBox(
//           // height: 63,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   int.parse(model.debit.toString().split('.')[0]) > 0
//                       ? Image.asset(
//                           width: 14, height: 18, AppImages.debitTranscationIcon)
//                       : Image.asset(
//                           width: 20,
//                           height: 20,
//                           AppImages.creditTranscationIcon,
//                         ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: getText(
//                         title:
//                             int.parse(model.debit.toString().split('.')[0]) > 0
//                                 ? getTranslated('funds_debited_to_admin', context)!
//                                 : getTranslated('funds_added', context)!,
//                         maxLies: 2,
//                         size: 13.5,
//                         fontFamily: FontFamily.poppinsMedium,
//                         color: AppColor.blackColor,
//                         fontWeight: FontWeight.w400),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   getText(
//                       title:
//                           "\$${int.parse(model.debit.toString().split('.')[0]) > 0 ? model.debit : model.credit}",
//                       size: 14,
//                       fontFamily: FontFamily.poppinsMedium,
//                       color: AppColor.blackColor,
//                       fontWeight: FontWeight.w400),
//                 ],
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 29),
//                 child: getText(
//                     title: TimeFormat.convertDateWithTime(model.createdAt),
//                     size: 12,
//                     fontFamily: FontFamily.poppinsRegular,
//                     color: AppColor.lightTextColor,
//                     fontWeight: FontWeight.w400),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width - 15,
//                 color: AppColor.borderD9Color,
//                 height: 1,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// dialogBox(){
//   showDialog(context: context, builder: (context){
//     return AlertDialog(
//       title: getText(
//                     title: "Coming Soon",
//                     size: 20,
//                     fontFamily: FontFamily.poppinsMedium,
//                     color: AppColor.blackColor,
//                     fontWeight: FontWeight.w500),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         getText(title: 'This Feature is Under Development – Stay Tuned for Updates!',
//                          size: 16, fontFamily: FontFamily.poppinsMedium, 
//                          color: AppColor.blackColor, fontWeight: FontWeight.w400),
//                          btn(title: "Okay",
//                            width: 200,color: AppColor.appTheme,
//                            onTap: (){})
//                       ],
//                     ),
//     );
//   });
// }


//   // paymentMethodBottomSheet() {
//   //   showModalBottomSheet(
//   //       backgroundColor: AppColor.whiteColor,
//   //       shape: const OutlineInputBorder(
//   //           borderRadius: BorderRadius.only(
//   //               topLeft: Radius.circular(15), topRight: Radius.circular(15))),
//   //       context: context,
//   //       builder: (context) {
//   //         return StatefulBuilder(builder: (context, state) {
//   //           return Padding(
//   //             padding: const EdgeInsets.only(
//   //                 top: 25, left: 15, right: 15, bottom: 20),
//   //             child: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 getText(
//   //                     title: 'Payment Method',
//   //                     size: 20,
//   //                     fontFamily: FontFamily.nunitoMedium,
//   //                     color: AppColor.blackColor,
//   //                     fontWeight: FontWeight.w500),
//   //                 ScreenSize.height(20),
//   //                 paymentType('Credit Card', 1, state),
//   //                 ScreenSize.height(20),
//   //                 paymentType('Nequi payment', 2, state),
//   //                 // ScreenSize.height(20),
//   //                 // paymentType('Pse payment', 3, state),
//   //                 ScreenSize.height(25),
//   //                 AppButton(
//   //                     title: getTranslated('continue', context)!,
//   //                     height: 50,
//   //                     width: double.infinity,
//   //                     buttonColor: AppColor.appTheme,
//   //                     onTap: () {
//   //                       if (selectIndex != 0) {
//   //                         clearControlles();
//   //                         // if(selectIndex==3){
//   //                         //   pseBankList();
//   //                         // }
//   //                         // else{
//   //                         dialogBox(paymentMethodIndex: selectIndex);
//   //                         // }
//   //                       } else {
//   //                         Utils.showToast("Please select payment method");
//   //                       }
//   //                     })
//   //               ],
//   //             ),
//   //           );
//   //         });
//   //       });
//   // }

//   final holderNameController = TextEditingController();
//   final mmYYController = TextEditingController();
//   final cvcController = TextEditingController();
//   final accountNumberController = TextEditingController();
//   final amountController = TextEditingController();

//   // clearControlles() {
//   //   holderNameController.clear();
//   //   mmYYController.clear();
//   //   cvcController.clear();
//   //   accountNumberController.clear();
//   //   amountController.clear();
//   //   selectedDropDownValue=null;
//   // }

//   // dialogBox({required int paymentMethodIndex}) {
//   //   showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return StatefulBuilder(builder: (context, state) {
//   //           return AlertDialog(
//   //               backgroundColor: AppColor.whiteColor,
//   //               title: getText(
//   //                   title: paymentMethodIndex == 1
//   //                       ? 'Enter Card Details'
//   //                       : paymentMethodIndex == 2
//   //                           ? "Nequi Payment"
//   //                           : "Pse Payment",
//   //                   size: 20,
//   //                   fontFamily: FontFamily.poppinsMedium,
//   //                   color: AppColor.blackColor,
//   //                   fontWeight: FontWeight.w500),
//   //               actions: [
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     Navigator.of(context).pop(); // Close the dialog
//   //                   },
//   //                   child: const Text('Cancel'),
//   //                 ),
//   //                 TextButton(
//   //                   onPressed: () {
//   //                     if (formKey.currentState!.validate()) {
//   //                       print(accountNumberController.text);
//   //                       if(selectIndex==1){
//   //                         creditCardPaymentMethod(
//   //                           cardNumber: accountNumberController.text
//   //                               .replaceAll(RegExp(r'\s+'), ''),
//   //                           cvcCode: cvcController.text,
//   //                           expYear: mmYYController.text.split('/')[1],
//   //                           expMonth: mmYYController.text.split('/')[0],
//   //                           amount: int.parse(amountController.text),
//   //                           cardHolderName: holderNameController.text);
//   //                       }
//   //                       else{
//   //                         nequiPaymentMethod(accountNumberController.text, int.parse(amountController.text));
//   //                       }
//   //                     }
//   //                   },
//   //                   child: getText(
//   //                       title: getTranslated('continue', context)!,
//   //                       size: 14,
//   //                       fontFamily: FontFamily.poppinsMedium,
//   //                       color: AppColor.appTheme,
//   //                       fontWeight: FontWeight.w500),
//   //                 ),
//   //               ],
//   //               content: Form(
//   //                   key: formKey,
//   //                   child: paymentMethodIndex == 1
//   //                       ? cardDetails(state):
//   //                       // : paymentMethodIndex == 2
//   //                           // ? 
//   //                           nequiPaymentDetails()
//   //                           // : psePaymentDetails()
//   //                           ));
//   //         });
//   //       });
//   // }

//   // cardDetails(state) {
//   //   return SingleChildScrollView(
//   //     child: Column(
//   //       mainAxisSize: MainAxisSize.min,
//   //       children: [
//   //         RectangleTextfield(
//   //           hintText: 'Enter holder name',
//   //           controller: holderNameController,
//   //           textInputAction: TextInputAction.next,
//   //           validator: (val) {
//   //             if (val.isEmpty) {
//   //               return "Enter holder name";
//   //             }
//   //           },
//   //         ),
//   //         ScreenSize.height(20),
//   //         RectangleTextfield(
//   //           hintText: '#### #### #### ####',
//   //           controller: accountNumberController,
//   //           textInputAction: TextInputAction.next,
//   //           inputFormatters: [
//   //             CardNumberInputFormatter(),
//   //           ],
//   //           textInputType: TextInputType.number,
//   //           suffix: Container(
//   //             height: 20,
//   //             width: 20,
//   //             alignment: Alignment.center,
//   //             child: Image.asset(
//   //               AppImages.atmCardIcon,
//   //               height: 30,
//   //               width: 30,
//   //             ),
//   //           ),
//   //           validator: (val) {
//   //             if (val.isEmpty) {
//   //               return "Enter account number";
//   //             } else if (val.length < 16) {
//   //               return "Account number should be valid";
//   //             }
//   //           },
//   //         ),
//   //         ScreenSize.height(20),
//   //         Row(
//   //           children: [
//   //             Expanded(
//   //               child: RectangleTextfield(
//   //                 hintText: 'MM/YY',
//   //                 controller: mmYYController,
//   //                 textInputAction: TextInputAction.next,
//   //                 inputFormatters: [ExpiryDateInputFormatter()],
//   //                 textInputType: TextInputType.number,
//   //                 validator: (val) {
//   //                   if (val.isEmpty) {
//   //                     return "Please enter mm/yy";
//   //                   } else if (val.length < 5) {
//   //                     return "mm/yy should be valid";
//   //                   }
//   //                 },
//   //               ),
//   //             ),
//   //             ScreenSize.width(15),
//   //             Expanded(
//   //               child: RectangleTextfield(
//   //                 hintText: 'CVC',
//   //                 controller: cvcController,
//   //                 textInputAction: TextInputAction.next,
//   //                 inputFormatters: [
//   //                   LengthLimitingTextInputFormatter(3),
//   //                   FilteringTextInputFormatter.digitsOnly
//   //                 ],
//   //                 textInputType: TextInputType.number,
//   //                 validator: (val) {
//   //                   if (val.isEmpty) {
//   //                     return "Enter cvc number";
//   //                   } else if (val.length < 3) {
//   //                     return "Cvc number should be valid";
//   //                   }
//   //                 },
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         ScreenSize.height(20),
//   //         RectangleTextfield(
//   //           hintText: 'Enter amount',
//   //           controller: amountController,
//   //           textInputAction: TextInputAction.next,
//   //           inputFormatters: [
//   //             FilteringTextInputFormatter.digitsOnly,
//   //           ],
//   //           textInputType: TextInputType.number,
//   //           validator: (val) {
//   //             if (val.isEmpty) {
//   //               return "Enter amount";
//   //             } else {
//   //               int amount = int.parse(val); // If parsing fails, default to 0
//   //               if (amount <= 99) {
//   //                 return "Amount must be greater than 99";
//   //               }
//   //             }
//   //           },
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // nequiPaymentDetails() {
//   //   return Column(
//   //     mainAxisSize: MainAxisSize.min,
//   //     children: [
//   //       RectangleTextfield(
//   //         hintText: 'Phone number to pay',
//   //         controller: accountNumberController,
//   //         inputFormatters: [
//   //           FilteringTextInputFormatter.digitsOnly,
//   //         ],
//   //         textInputType: TextInputType.number,
//   //         validator: (val) {
//   //           if (val.isEmpty) {
//   //             return "Enter number";
//   //           } else if (val.length < 10) {
//   //             return "Number should be valid";
//   //           }
//   //         },
//   //       ),
//   //       ScreenSize.height(20),
//   //       RectangleTextfield(
//   //         hintText: 'Enter amount',
//   //         controller: amountController,
//   //         inputFormatters: [
//   //           FilteringTextInputFormatter.digitsOnly,
//   //         ],
//   //         textInputType: TextInputType.number,
//   //         validator: (val) {
//   //           if (val.isEmpty) {
//   //             return "Enter amount";
//   //           } else {
//   //             int amount = int.parse(val); // If parsing fails, default to 0
//   //             if (amount <= 99) {
//   //               return "Amount must be greater than 99";
//   //             }
//   //           }
//   //         },
//   //       ),
//   //     ],
//   //   );
//   // }

//   // psePaymentDetails() {
//   //   return StatefulBuilder(builder: (context, state) {
//   //     return Column(
//   //       mainAxisSize: MainAxisSize.min,
//   //       children: [
//   //         dropdownWidget(state),
//   //         ScreenSize.height(20),
//   //         RectangleTextfield(
//   //           controller: amountController,
//   //           hintText: 'Enter amount',
//   //           inputFormatters: [
//   //             FilteringTextInputFormatter.digitsOnly,
//   //           ],
//   //           textInputType: TextInputType.number,
//   //           validator: (val) {
//   //             if (val.isEmpty) {
//   //               return "Enter amount";
//   //             } else {
//   //               int amount = int.parse(val); // If parsing fails, default to 0
//   //               if (amount <= 99) {
//   //                 return "Amount must be greater than 99";
//   //               }
//   //             }
//   //           },
//   //         ),
//   //       ],
//   //     );
//   //   });
//   // }

//   // dropdownWidget(state) {
//   //   return DropdownButtonHideUnderline(
//   //     child: DropdownButton2<String>(
//   //       isExpanded: true,
//   //       hint: Row(
//   //         children: [
//   //           Expanded(
//   //               child: getText(
//   //                   title: 'Select bank',
//   //                   fontWeight: FontWeight.w400,
//   //                   size: 13.5,
//   //                   color: AppColor.textBlackColor,
//   //                   fontFamily: FontFamily.poppinsRegular)),
//   //         ],
//   //       ),
//   //       items: bankList
//   //           .map((item) => DropdownMenuItem<String>(
//   //               value: item,
//   //               child: getText(
//   //                 title: item,
//   //                 size: 14,
//   //                 color: AppColor.blackColor,
//   //                 fontWeight: FontWeight.w400,
//   //                 fontFamily: FontFamily.poppinsRegular,
//   //               )))
//   //           .toList(),
//   //       value: selectedDropDownValue,
//   //       onChanged: (value) {
//   //         state(() {
//   //           selectedDropDownValue = value;
//   //         });
//   //       },
//   //       buttonStyleData: ButtonStyleData(
//   //         height: 50,
//   //         width: double.infinity,
//   //         padding: const EdgeInsets.only(left: 16, right: 16),
//   //         decoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(10),
//   //           border: Border.all(
//   //             color: AppColor.lightTextColor.withOpacity(.6),
//   //           ),
//   //           color: AppColor.whiteColor,
//   //         ),
//   //         elevation: 0,
//   //       ),
//   //       iconStyleData: const IconStyleData(
//   //         icon: Icon(
//   //           Icons.keyboard_arrow_down,
//   //         ),
//   //         iconSize: 20,
//   //       ),
//   //       dropdownStyleData: DropdownStyleData(
//   //         maxHeight: 200,
//   //         width: MediaQuery.sizeOf(context).width - 120,
//   //         decoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(14),
//   //           color: AppColor.whiteColor,
//   //         ),
//   //         offset: const Offset(-10, 0),
//   //         scrollbarTheme: ScrollbarThemeData(
//   //           radius: const Radius.circular(40),
//   //           thickness: MaterialStateProperty.all(6),
//   //           thumbVisibility: MaterialStateProperty.all(true),
//   //         ),
//   //       ),
//   //       menuItemStyleData: const MenuItemStyleData(
//   //         height: 40,
//   //         padding: EdgeInsets.only(left: 14, right: 14),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // paymentType(String title, index, state) {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       state(() {
//   //         selectIndex = index;
//   //       });
//   //     },
//   //     child: DottedBorder(
//   //       borderType: BorderType.RRect,
//   //       radius: const Radius.circular(12),
//   //       color: AppColor.lightPinkColor,
//   //       child: Container(
//   //         width: double.infinity,
//   //         color: selectIndex == index
//   //             ? AppColor.lightPinkColor.withOpacity(.09)
//   //             : AppColor.lightTextColor.withOpacity(.08),
//   //         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
//   //         child: getText(
//   //             title: title,
//   //             size: 18,
//   //             fontFamily: FontFamily.poppinsMedium,
//   //             color: AppColor.blueColor,
//   //             fontWeight: FontWeight.w600),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // errorDialogBox(String title, String des) {
//   //   showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return AlertDialog(
//   //           title: Text(title),
//   //           content: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               Center(
//   //                 child: Text(des),
//   //               ),
//   //             ],
//   //           ),
//   //           actions: [
//   //             TextButton(
//   //                 onPressed: () {
//   //                   Navigator.pop(context);
//   //                 },
//   //                 child: const Text("Ok"))
//   //           ],
//   //         );
//   //       });
//   // }

// }
