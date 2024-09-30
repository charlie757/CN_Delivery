import 'package:cn_delivery/widget/appBar.dart';
import 'package:flutter/material.dart';

class ChooseVehicleScreen extends StatefulWidget {
  const ChooseVehicleScreen({super.key});

  @override
  State<ChooseVehicleScreen> createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Vehcile"),
      body: Column(
        children: [

        ],
      ),
    );
  }
}