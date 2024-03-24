import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/componenets/my_snackbar.dart';
import 'package:demo_google/models/mysimulation.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/repositories/mysimulation_repository.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/simulation_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSimulationAccScreen extends StatefulWidget {
  const AddSimulationAccScreen({super.key});

  @override
  State<AddSimulationAccScreen> createState() => _AddSimulationAccScreenState();
}

class _AddSimulationAccScreenState extends State<AddSimulationAccScreen> {
  final ageController = TextEditingController();
  final assetsController = TextEditingController();
  String? employmentStatus;
  String? salary;
  final user = FirebaseAuth.instance.currentUser!;
  final _simulationRepo = MySimulationRepository();

  var employmentStatuses = ['Unemployed', 'Employed'];
  var salaries = [
    '< RM 1,000',
    'RM 2,000 - RM 3,999',
    'RM 4,000 - RM 5,999',
    'RM 6,000 - RM 7,999',
    'RM 8,000 - RM 9,999',
    '> RM 10,000'
  ];

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: mHeight*0.09401,),
                Text('Simulation Profile', style: TextStyle(fontSize: mHeight*0.0258, fontWeight: FontWeight.bold),),

                SizedBox(height: mHeight*0.0235,),

                Container(
                  height: mHeight*0.1057,
                  width: mWidth*0.2291,
                  margin: EdgeInsets.only(right: mWidth*0.02037),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('images/avatar.png')),
                  ),
                ),

                SizedBox(height: mHeight*0.047008,),

                // age
                Padding(
                padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => ageController.clear(), 
                      icon: Icon(Icons.close_rounded))
                  ),
                ),
              ),

                // age
                Padding(
                padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                child: TextField(
                  controller: assetsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Savings (RM)',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => assetsController.clear(), 
                      icon: Icon(Icons.close_rounded))
                  ),
                ),
              ),

              SizedBox(height: mHeight*0.0117,),

                // employment status
                Padding(
                  padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                  child: DropdownButtonFormField<String>(
                      value: null,
                      hint: Text(
                        "Employment Status",
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                        ),
                      ),
                      items: employmentStatuses.map((String status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(
                            status,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          employmentStatus = newValue!;
                          if (employmentStatus == 'Unemployed') {
                            salary = 'RM 0';
                          } else {
                            salary = null;
                          }
                        });
                      }),
                ),

                SizedBox(height: mHeight*0.0117,),

                // salary
                Padding(
                  padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                  child: DropdownButtonFormField<String>(
                      value: employmentStatus == 'Unemployed' ? 'RM 0' : null,
                      hint: Text(
                        "Salary",
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: employmentStatus == 'Unemployed' ? Colors.grey : Colors.black)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                        ),
                      ),
                      items: employmentStatus == 'Unemployed'
                          ? const [
                              DropdownMenuItem(
                                value: 'RM 0',
                                child: Text('RM 0'),
                              ),
                            ]
                          : salaries.map((String salary) {
                              return DropdownMenuItem(
                                value: salary,
                                child: Text(
                                  salary,
                                ),
                              );
                            }).toList(),
                      onChanged: employmentStatus == 'Unemployed'
                          ? null
                          : (String? newValue) {
                              setState(() {
                                salary = newValue!;
                              });
                            }),
                ),

                SizedBox(
                  height: mHeight*0.21153,
                ),

                GestureDetector(
                  onTap: () => addSimulationAcc(),
                  child: Container(
                    margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                    width: double.infinity,
                    height: mHeight*0.07051,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.blue.shade100,
                    ),
                    child: Center(
                      child: Text('Start',)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addSimulationAcc() async {
    // check if every field is filled completely
    if (ageController.text != "" &&
        assetsController.text != "" &&
        employmentStatus != null &&
        salary != null) {

      List<double> currentAssetsList = [];
      currentAssetsList.add(double.parse(assetsController.text));

      // get the simulationModel in type of MySimulation
      MySimulation simulationModel = MySimulation(
          age: int.parse(ageController.text),
          currentAssets: currentAssetsList,
          employmentStatus: employmentStatus!,
          salary: salary!,
          timestamp: Timestamp.now(),
          properties: [],
          fds: [],
          stocks: []);

      // pass the uid and userModel to userRepo to add to the Firestore
      DocumentReference docRef = await _simulationRepo.addSimulationAcc(uid: user.uid, simulation: simulationModel);
      String simulationId = docRef.id;

      context.read<SimulationProvider>().getSimulationDetails(currentAssets: double.parse(assetsController.text), employmentStatus: employmentStatus!, age: int.parse(ageController.text), simulationId: simulationId, propertyIds: [], bankIds: []);

      // navigate to the Simulation Main Screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SimulationHomeScreen())));
    } else {
      showSnackBar(context, "Please fill in every section before proceeding");
    }
  }
}
