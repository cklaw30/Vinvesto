import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/componenets/market_bank_tile.dart';
import 'package:demo_google/componenets/my_bank_tile.dart';
import 'package:demo_google/componenets/my_linechart.dart';
import 'package:demo_google/componenets/property_owned_tile.dart';
import 'package:demo_google/componenets/property_tosell_tile.dart';
import 'package:demo_google/componenets/simulation_acc_tile.dart';
import 'package:demo_google/componenets/stock_owned_tile.dart';
import 'package:demo_google/componenets/stock_tosell_tile.dart';
import 'package:demo_google/models/myuser.dart';
import 'package:demo_google/providers/bank_provider.dart';
import 'package:demo_google/providers/owned_property_provider.dart';
import 'package:demo_google/providers/property_provider.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/repositories/bank_repository.dart';
import 'package:demo_google/repositories/myuser_repository.dart';
import 'package:demo_google/repositories/owned_property_repository.dart';
import 'package:demo_google/repositories/property_repository.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/fd_screens/add_bank_screen.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/property_screens/add_property_screen.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/fd_screens/make_fd_screen.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/property_screens/property_detail_screen.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/total_assets_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimulationHomeScreen extends StatefulWidget {
  const SimulationHomeScreen({super.key});

  @override
  State<SimulationHomeScreen> createState() => _SimulationHomeScreenState();
}

class _SimulationHomeScreenState extends State<SimulationHomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _ownedPropertyRepo = OwnedPropertyRepository();
  final _userRepo = MyUserRepository();
  final _propertyRepo = PropertyRepository();
  final _bankRepo = BankRepository();
  List<String> items = [
    'Property',
    'Stock',
    'e-FD',
  ];

  double mHeight = 0.0;
  double mWidth = 0.0;

  int current = 0;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    getIsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimulationAccTile(
                  currentAssets:
                      context.watch<SimulationProvider>().currentAssets,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TotalAssetsDetailScreen()))),
              SizedBox(
                height: mHeight * 0.07051,
                width: double.infinity,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: mHeight * 0.005876,
                              bottom: mHeight * 0.005876,
                              left: mWidth * 0.01273,
                              right: mWidth * 0.01273),
                          width: mWidth * 0.3055,
                          height: mHeight * 0.05288,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: current == index
                                ? Border.all(
                                    color: Colors.blue.shade100,
                                    width: mWidth * 0.0050925572276118)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              items[index],
                              style: TextStyle(fontSize: mHeight * 0.01645),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: mWidth * 0.03055,
                    right: mWidth * 0.03055,
                    top: mHeight * 0.005876,
                    bottom: mHeight * 0.005876),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'My investment',
                      style: TextStyle(
                          fontSize: mHeight * 0.01880,
                          fontWeight: FontWeight.bold),
                    )),
                    // Text(
                    //   'View All',
                    //   style: TextStyle(
                    //       color: Colors.blue.shade900,
                    //       fontSize: mHeight * 0.01880,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
              getInvestment(),
              Padding(
                padding: EdgeInsets.only(
                  left: mWidth * 0.03055,
                  right: mWidth * 0.03055,
                  top: mHeight * 0.017628,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Market',
                      style: TextStyle(
                          fontSize: mHeight * 0.01880,
                          fontWeight: FontWeight.bold),
                    )),
                    // Text(
                    //   'View All',
                    //   style: TextStyle(
                    //       color: Colors.blue.shade900,
                    //       fontSize: mHeight * 0.01880,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
              getMarket(),
            ],
          ),
        ),
      ),
      floatingActionButton: FutureBuilder(
          future: getIsAdmin(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              isAdmin = snapshot.data!;
              if (isAdmin) {
                return FloatingActionButton(
                  onPressed: () => current == 0
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => AddPropertyScreen())))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => AddBankScreen()))),
                  child: const Icon(Icons.add),
                );
              } else {
                return Container();
              }
            }
          })),
    );
  }

  Future<bool> getIsAdmin() async {
    MyUser? userModel;
    String? role;
    userModel = await _userRepo.getUserDetails(uid: user.uid);

    role = userModel.role;
    if (role == 'Admin') {
      return true;
    } else {
      return false;
    }
  }

  Widget getInvestment() {
    switch (current) {
      case 0:
        final sp = Provider.of<SimulationProvider>(context, listen: false);
        return SizedBox(
          height: mHeight * 0.1762,
          width: double.infinity,
          child: StreamBuilder(
              stream: _ownedPropertyRepo.getOwnedPropertyStream(
                  uid: user.uid, simulationId: sp.simulationId),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Connection Error');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var docs = snapshot.data!;
                List<Map<String, dynamic>> properties =
                    List<Map<String, dynamic>>.from(docs['properties'] ?? []);

                if (properties.isEmpty) {
                  return Center(
                      child: Container(
                          width: double.infinity,
                          height: mHeight * 0.1645,
                          margin: EdgeInsets.only(
                              top: mHeight * 0.009401,
                              bottom: mHeight * 0.009401,
                              left: mWidth * 0.02037,
                              right: mWidth * 0.02037),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.blue.shade50,
                          ),
                          child: Center(
                            child: Text('You haven\'t bought any property yet'),
                          )));
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: properties.length,
                    itemBuilder: ((context, index) {
                      final property = properties[index];
                      return PropertyOwnedTile(
                        onTap: () {
                          context
                              .read<OwnedPropertyProvider>()
                              .getOwnedPropertyDetails(
                                  datePaid: List<Timestamp>.from(
                                      property['datePaid']),
                                  downPayment: property['downPayment'],
                                  interest: property['interest'],
                                  loan: property['loan'],
                                  monthlyRepayment:
                                      property['monthlyRepayment'],
                                  tenure: property['tenure'],
                                  timeStamp: property['timeStamp']);
                          context.read<PropertyProvider>().getPropertyDetails(
                              imagePath: property['imagePath'],
                              name: property['name'],
                              price: property['price'],
                              type: property['type'],
                              bedroom: property['bedroom'],
                              bathroom: property['bathroom'],
                              sqft: property['sqft'],
                              street: property['street'],
                              city: property['city'],
                              county: property['county'],
                              propertyId: property['propertyId']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      PropertyDetailScreen())));
                        },
                        imagePath: property['imagePath'],
                        name: property['name'],
                        price: property['price'],
                        monthlyRepayment: property['monthlyRepayment'],
                        tenure: property['tenure'],
                        type: property['type'],
                        datePaid: List<Timestamp>.from(property['datePaid']),
                      );
                    }),
                  );
                }
              })),
        );
      case 1:
        return Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: mHeight * 0.009401),
                width: double.infinity,
                height: mHeight * 0.05171,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: mWidth * 0.08912,
                        ),
                        Text('Asset', style: TextStyle(fontSize: mHeight * 0.01645),),
                        SizedBox(
                          width: mWidth * 0.18333,
                        ),
                        Text('Invested', style: TextStyle(fontSize: mHeight * 0.01645),),
                        SizedBox(
                          width: mWidth * 0.13241,
                        ),
                        Text('P/L', style: TextStyle(fontSize: mHeight * 0.01645),),
                        SizedBox(
                          width: mWidth * 0.14514,
                        ),
                        Text('Value', style: TextStyle(fontSize: mHeight * 0.01645),),
                      ],
                    ),
                    Divider(
                      height: mHeight * 0.0183033987143176,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: mHeight * 0.08579,
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: ((context, index) {
                      return StockOwnedTile();
                    })),
              ),
            ],
          ),
        );
      default:
        return Container(
            width: double.infinity,
            height: mHeight * 0.11752,
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return MyBankTile();
                })));
    }
  }

  Widget getMarket() {
    switch (current) {
      case 0:
        final sp = Provider.of<SimulationProvider>(context, listen: false);
        return SizedBox(
            height: mHeight * 0.4113,
            width: double.infinity,
            child: StreamBuilder(
              stream: _propertyRepo.getPropertyStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Connection Error');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var docs = snapshot.data!.docs;
                var filteredDocs = docs
                    .where((property) => !sp.propertyIds.contains(property.id))
                    .toList();

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final property = filteredDocs[index];
                    return PropertyToSellTile(
                      onTap: () {
                        context.read<PropertyProvider>().getPropertyDetails(
                              imagePath: property['imagePath'],
                              name: property['name'],
                              price: property['price'],
                              type: property['type'],
                              bedroom: property['bedroom'],
                              bathroom: property['bathroom'],
                              sqft: property['sqft'],
                              street: property['street'],
                              city: property['city'],
                              county: property['county'],
                              propertyId: property.id,
                            );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PropertyDetailScreen()));
                      },
                      imagePath: property['imagePath'],
                      name: property['name'],
                      price: property['price'],
                      bedroom: property['bedroom'],
                      bathroom: property['bathroom'],
                      type: property['type'],
                    );
                  },
                );
              },
            ));
      case 1:
        // List<double> stockYList = [3, 4, 2, 2, 3, 1.5, 4, 3, 0, 5, 6, 8, 10, 7, 8, 14, 13, 17, 16, 16.5, 14, 22, 20, 23, 23, 20, 22];
        List<double> stockYList = [
          3,
          4,
          2,
          2,
          3,
          15,
          8,
          20,
          10,
          5,
          35,
          40,
          50,
          60,
          40,
          50,
          75,
          70,
          93,
          85,
          90,
          80,
          150,
          122,
          170,
          132,
          154.19
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: mWidth * 0.03056),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GLG',
                    style: TextStyle(
                        fontSize: mHeight * 0.0188,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('RM154.19'),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                height: mHeight * 0.17041,
                margin: EdgeInsets.only(
                    top: mHeight * 0.014102,
                    bottom: mHeight * 0.014102,
                    left: mWidth * 0.03056,
                    right: mWidth * 0.03056),
                child: MyLineChart(
                  yList: stockYList,
                  data: true,
                )),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: mHeight * 0.009401),
                    width: double.infinity,
                    height: mHeight * 0.05171,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: mHeight * 0.04113,
                            ),
                            Text('Markets', style: TextStyle(fontSize: mHeight * 0.01645),),
                            SizedBox(
                              width: mWidth * 0.25463,
                            ),
                            Text('Short', style: TextStyle(fontSize: mHeight * 0.01645),),
                            SizedBox(
                              width: mWidth * 0.241896,
                            ),
                            Text('Buy', style: TextStyle(fontSize: mHeight * 0.01645),),
                          ],
                        ),
                        Divider(
                          height: mHeight * 0.0183033987143176,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: mHeight * 0.17041,
                    child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return StockToSellTile();
                        })),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        return Container(
            width: double.infinity,
            height: mHeight * 0.470085,
            child: StreamBuilder(
                stream: _bankRepo.getBankStream(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Connection Error');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var docs = snapshot.data!.docs;
                  // List<Map<String, dynamic>> ffo = List<Map<String, dynamic>>.from(docs['ffo'] ?? []);

                  return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: ((context, index) {
                        final sp = Provider.of<SimulationProvider>(context,
                            listen: false);
                        final bank = docs[index];
                        List<Map<String, dynamic>> ffo =
                            List<Map<String, dynamic>>.from(bank['ffo'] ?? []);
                        List<Map<String, dynamic>> ffs =
                            List<Map<String, dynamic>>.from(bank['ffs'] ?? []);
                        bool isOpenedAcc;
                        if (sp.bankIds.isEmpty) {
                          isOpenedAcc = false;
                        } else {
                          isOpenedAcc = sp.bankIds.contains(bank.id);
                        }
                        return MarketBankTile(
                            onTap: () {
                              context.read<BankProvider>().getBankDetails(
                                  bankId: bank.id,
                                  name: bank['name'],
                                  isOpenedAcc: isOpenedAcc);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MakeFDScreen()));
                            },
                            imagePath: bank['imagePath'],
                            name: bank['name'],
                            ffo: ffo,
                            ffs: ffs);
                      }));
                })));
    }
  }
}
