import 'package:demo_google/providers/property_provider.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/property_screens/bought_property_screen.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/property_screens/buy_property_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final price = context.watch<PropertyProvider>().price;
    final sp = Provider.of<SimulationProvider>(context, listen: false);
    final pp = Provider.of<PropertyProvider>(context, listen: false);
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  width: double.infinity,
                  height: mHeight * 0.35256,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(pp.imagePath)),
                  ),
                ),

                // name
                Padding(
                  padding: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  child: Text(
                    pp.name,
                    style: TextStyle(
                        fontSize: mHeight * 0.03291,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // address
                Padding(
                  padding: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  child: Text(pp.street + ', ' + pp.city + ', ' + pp.county),
                ),

                // price
                Padding(
                  padding: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  child: Text(
                    'RM ' + pp.price.toString(),
                    style: TextStyle(fontSize: 28),
                  ),
                ),

                // bedroom & bathroom
                Padding(
                  padding: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.bed_rounded,
                            size: mHeight * 0.04113,
                          ),
                          Text(
                            '${pp.bedroom.toString()} bed',
                            style: TextStyle(fontSize: mHeight * 0.0188),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: mWidth * 0.05093,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.bathtub_outlined,
                            size: mHeight * 0.04113,
                          ),
                          Text(
                            '${pp.bathroom.toString()} bath',
                            style: TextStyle(fontSize: mHeight * 0.0188),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: mWidth * 0.05093,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'images/sqft.png',
                            height: mHeight * 0.03761,
                          ),
                          Text(
                            '${pp.sqft.toString()} sqft',
                            style: TextStyle(fontSize: mHeight * 0.0188),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // type
                Container(
                  margin: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  padding: EdgeInsets.only(
                      top: mHeight * 0.00235,
                      bottom: mHeight * 0.00235,
                      left: mWidth * 0.00509,
                      right: mWidth * 0.00509),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(pp.type),
                ),
              ],
            ),
          ),

          sp.propertyIds.contains(pp.propertyId)
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => BoughtPropertyScreen())));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: mHeight * 0.009401,
                        bottom: mHeight * 0.009401,
                        left: mWidth * 0.02037,
                        right: mWidth * 0.02037),
                    width: double.infinity,
                    height: mHeight * 0.07051,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(child: Text('More')),
                  ),
                )
              :
              // buy button
              GestureDetector(
                  onTap: sp.employmentStatus == 'Employed'
                      ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => BuyPropertyScreen(
                                    price: price,
                                  ))))
                      : () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Unemployed'),
                                    content: const Text(
                                        'You have no source income and you are not able to borrow loan, still proceed to buying property simulation?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text('No')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        BuyPropertyScreen(
                                                          price: price,
                                                        ))));
                                          },
                                          child: Text('Yes')),
                                    ],
                                  ));
                        },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: mHeight * 0.009401,
                        bottom: mHeight * 0.009401,
                        left: mWidth * 0.02037,
                        right: mWidth * 0.02037),
                    width: double.infinity,
                    height: mHeight * 0.07051,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(child: Text('Buy Now')),
                  ),
                )
        ],
      )),
    );
  }
}
