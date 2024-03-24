import 'dart:io';

import 'package:demo_google/componenets/my_button.dart';
import 'package:demo_google/componenets/my_textfield.dart';
import 'package:demo_google/models/bank.dart';
import 'package:demo_google/repositories/bank_repository.dart';
import 'package:demo_google/utils/pick_image.dart';
import 'package:flutter/material.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  File? image;
  final nameController = TextEditingController();
  final minDepositController = TextEditingController();
  final _bankRepo = BankRepository();

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                  onTap: () => selectImage(),
                  child: image == null
                      ? Container(
                          margin: EdgeInsets.only(top: mHeight * 0.0235),
                          height: MediaQuery.of(context).size.height * 0.2350,
                          width: MediaQuery.of(context).size.width * 0.7129,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_home_work_outlined,
                                size: mHeight * 0.11752,
                              ),
                              Text(
                                "Select an image",
                                style: TextStyle(
                                    fontSize: mHeight * 0.0188,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: mHeight * 0.0235),
                          height: MediaQuery.of(context).size.height * 0.2350,
                          width: MediaQuery.of(context).size.width * 0.7129,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                                fit: BoxFit.fill, image: FileImage(image!)),
                          ),
                        )),
              MyTextField(
                  controller: nameController,
                  hintText: 'Bank Name',
                  obsureText: false,
                  inputType: TextInputType.name),
              MyTextField(
                  controller: minDepositController,
                  hintText: 'Minimum Deposit',
                  obsureText: false,
                  inputType: TextInputType.number),
              MyButton(
                onTap: () => addBankToMarket(context),
                text: "Add",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addBankToMarket(BuildContext context) async {
    if (image != null &&
        nameController.text.trim() != "" &&
        minDepositController.text.trim() != "") {
      showDialog(
          context: context,
          builder: (context) {
            final mHeight = MediaQuery.of(context).size.height;
            final mWidth = MediaQuery.of(context).size.width;
            return Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: mHeight * 0.014102,
                    bottom: mHeight * 0.014102,
                    left: mWidth * 0.03056,
                    right: mWidth * 0.03056),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16.0)),
                child: Text(
                  'Uploading... Please wait',
                  style: TextStyle(
                      fontSize: mHeight * 0.0188, color: Colors.black),
                ),
              ),
            );
          });

      String downloadUrl = await uploadImageToStorage(image!, 'bank');

      Bank bankModel = Bank(
          imagePath: downloadUrl,
          name: nameController.text,
          ffs: [],
          ffo: [],
          minDeposit: double.parse(minDepositController.text));

      _bankRepo.addBank(bank: bankModel);

      Navigator.of(context).pop();
      Navigator.pop(context);
    } else {
      showSnackBar(context, 'Please fill in every section');
    }
  }
}
