import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final firstNameController = TextEditingController(text: 'First Name');
  final lastNameController = TextEditingController(text: 'Last Name');
  final mobileController = TextEditingController(text: 'Mobile Number');
  final emailController = TextEditingController(text: 'Email Address');
  final addressController = TextEditingController(text: 'Address');
  final cityController = TextEditingController(text: 'City');
  final stateController = TextEditingController(text: 'State');
  final countryController = TextEditingController(text: 'Country');
  final stateIdController = TextEditingController(text: 'State ID');
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
}
