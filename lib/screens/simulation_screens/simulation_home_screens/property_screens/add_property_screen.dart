import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/componenets/my_button.dart';
import 'package:demo_google/componenets/my_textfield.dart';
import 'package:demo_google/models/property.dart';
import 'package:demo_google/repositories/property_repository.dart';
import 'package:demo_google/utils/pick_image.dart';
import 'package:flutter/material.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  String? type;
  String? county;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  TextEditingController bedroomController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();
  final streetController = TextEditingController();
  // TextEditingController address2Controller = TextEditingController();
  final postcodeController = TextEditingController();
  final cityController = TextEditingController();
  final sqftController = TextEditingController();
  final _propertyRepo = PropertyRepository();
  
  File? image;

  var types = ['Condominium', 'Banglo', 'Semi-Detached House', 'Studio'];
  var counties = ['Johor', 'Kedah', 'Kelantan', 'Kuala Lumpur', 'Labuan', 'Malacca', 'Negeri Sembilan', 'Pahang', 'Penang', 'Perak', 'Perlis', 'Putrajaya', 'Sabah', 'Sarawak', 'Selangor', 'Terengganu'];

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // logo
                InkWell(
                    onTap: () => selectImage(),
                    child: image == null
                        ? Container(
                            margin: EdgeInsets.only(top: mHeight*0.0235),
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
                                  size: mHeight*0.1175,
                                ),
                                Text(
                                  "Select an image",
                                  style: TextStyle(
                                      fontSize: mHeight*0.0188, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: mHeight*0.0235),
                            height: MediaQuery.of(context).size.height * 0.2350,
                            width: MediaQuery.of(context).size.width * 0.7129,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: FileImage(image!)),
                            ),
                          )),

                SizedBox(
                  height: mHeight*0.0293,
                ),

                // password
                MyTextField(
                  controller: nameController,
                  hintText: "Project Name",
                  obsureText: false,
                  inputType: TextInputType.text,
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                MyTextField(
                  controller: priceController,
                  hintText: "Price to sell",
                  obsureText: false,
                  inputType: TextInputType.number,
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                // property type
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mWidth*0.0636),
                  child: DropdownButtonFormField<String>(
                      value: null,
                      hint: Text(
                        "Type",
                        style: TextStyle(
                          fontSize: mHeight*0.0176,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      style: TextStyle(color: Colors.grey.shade500),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      items: types.map((String type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(
                            type,
                            style: TextStyle(
                                fontSize: mHeight*0.0176, color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          type = newValue!;

                          if (type == 'Studio') {
                            bedroomController = TextEditingController(text: '1');
                            bathroomController = TextEditingController(text: '1');
                          }
                        });
                      }),
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                MyTextField(
                  enabled: type == 'Studio' ? false : true,
                  controller: bedroomController,
                  hintText: "Number of bedroom",
                  obsureText: false,
                  inputType: TextInputType.number,
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                MyTextField(
                  enabled: type == 'Studio' ? false : true,
                  controller: bathroomController,
                  hintText: "Number of bathroom",
                  obsureText: false,
                  inputType: TextInputType.number,
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                MyTextField(
                  controller: sqftController,
                  hintText: "Square feet",
                  obsureText: false,
                  inputType: TextInputType.number,
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                MyTextField(
                  controller: streetController,
                  hintText: "Street",
                  obsureText: false,
                  inputType: TextInputType.text,
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                // MyTextField(
                //   controller: address2Controller,
                //   hintText: "Address 2 (optional)",
                //   obsureText: false,
                //   inputType: TextInputType.text,
                // ),

                // const SizedBox(
                //   height: 10,
                // ),

                // MyTextField(
                //   controller: postcodeController,
                //   hintText: "Postcode",
                //   obsureText: false,
                //   inputType: TextInputType.number,
                // ),

                // const SizedBox(
                //   height: 10,
                // ),

                MyTextField(
                  controller: cityController,
                  hintText: "City",
                  obsureText: false,
                  inputType: TextInputType.text,
                ),

                SizedBox(
                  height: mHeight*0.0117,
                ),

                // county
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mWidth*0.0636),
                  child: DropdownButtonFormField<String>(
                      value: null,
                      hint: Text(
                        "County",
                        style: TextStyle(
                          fontSize: mHeight*0.0176,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      style: TextStyle(color: Colors.grey.shade500),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      items: counties.map((String county) {
                        return DropdownMenuItem(
                          value: county,
                          child: Text(
                            county,
                            style:  TextStyle(
                                fontSize: mHeight*0.0176, color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          county = newValue!;
                        });
                      }),
                ),

                SizedBox(
                  height: mHeight*0.0293,
                ),

                // confirm button
                MyButton(
                  onTap: () => addPropertyToMarket(context),
                  text: "Add",
                ),

                SizedBox(height: mHeight*0.0235,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addPropertyToMarket(BuildContext context) async {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    if (image != null && nameController.text.trim() != "" && priceController.text.trim() != "" && bedroomController.text.trim() != "" && bathroomController.text.trim() != "" && sqftController.text.trim() != "" && type != null && streetController.text.trim() != "" && cityController.text.trim() != "" && county != null) {

      showDialog(
        context: context, 
        builder: (context) {
          return Center(
            child: Container(
              padding: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(16.0)
              ),
              child: Text('Uploading... Please wait', style: TextStyle(fontSize: mHeight*0.0188, color: Colors.black),),),);
      });

      String downloadUrl = await uploadImageToStorage(image!, 'property');

      Property propertyModel = Property(name: nameController.text, street: streetController.text, city: cityController.text, county: county!, type: type!, price: double.parse(priceController.text), bedroom: int.parse(bedroomController.text), bathroom: int.parse(bathroomController.text), imagePath: downloadUrl, sqft: int.parse(sqftController.text), timestamp: Timestamp.now());

      _propertyRepo.addProperty(property: propertyModel);

      Navigator.of(context).pop();
      Navigator.pop(context);
    } else {
      showSnackBar(context, 'Please fill in every section');
    }
    
  }
}
