import 'package:demo_google/componenets/simulation_acc_tile.dart';
import 'package:demo_google/models/in_bank.dart';
import 'package:demo_google/models/owned_property.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/repositories/mysimulation_repository.dart';
import 'package:demo_google/screens/simulation_screens/manage_screens/add_simulation_acc_screen.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/simulation_home_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimulationAccScreen extends StatefulWidget {
  const SimulationAccScreen({super.key});

  @override
  State<SimulationAccScreen> createState() => _SimulationAccScreenState();
}

class _SimulationAccScreenState extends State<SimulationAccScreen> {
  final _simulationRepo = MySimulationRepository();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mHeight * 0.06581,
        title: Text("Simulation", style: TextStyle(fontSize: mHeight*0.0329, fontWeight: FontWeight.bold),)),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            const AddSimulationAccScreen())));
              },
              child: Padding(
                padding: EdgeInsets.only(top: mHeight * 0.01410, bottom: mHeight * 0.01410, left: mWidth * 0.03055, right: mWidth * 0.03055),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(16.0),
                  child: Container(
                    width: double.infinity,
                    height: mHeight * 0.0940169935715881,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.add_circle,
                      size: mHeight * 0.047008,
                    ),
                  ),
                ),
              ),
            ),
            
            Flexible(
              child: StreamBuilder(
                  stream: _simulationRepo.getSimulationAccStream(uid: user.uid),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Connection Error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var docs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final simulation = docs[index];
                        List<double> currentAssetsList = List<double>.from(simulation['currentAssets'] ?? []);
                        double currentAssets = currentAssetsList.last;
                        return SimulationAccTile(currentAssets: currentAssets, onTap: () {
                          List<String> propertyIds = [];
                          List<String> bankIds = [];
                          for (var i in simulation['properties']) {
                            OwnedProperty ownedPropertyModel = OwnedProperty.fromMap(i);
                            propertyIds.add(ownedPropertyModel.propertyId);
                          }
                          for (var i in simulation['fds']) {
                            InBank inBankModel = InBank.fromMap(i);
                            bankIds.add(inBankModel.bankId);
                          }
                          context.read<SimulationProvider>().getSimulationDetails(currentAssets: currentAssets, employmentStatus: simulation['employmentStatus'], age: simulation['age'], simulationId: simulation.id, propertyIds: propertyIds, bankIds: bankIds);
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => SimulationHomeScreen())));
                        });
                      },
                    );
                  })),
            ),

            
          ],
        ),
      ),
    );
  }
}
