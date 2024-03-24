import 'package:demo_google/componenets/assets_history_tile.dart';
import 'package:demo_google/componenets/simulation_acc_tile.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalAssetsDetailScreen extends StatefulWidget {
  const TotalAssetsDetailScreen({super.key});

  @override
  State<TotalAssetsDetailScreen> createState() =>
      _TotalAssetsDetailScreenState();
}

class _TotalAssetsDetailScreenState extends State<TotalAssetsDetailScreen> {
  List<String> items = [
    'All',
    'Property',
    'Stock',
    'e-FD',
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SimulationAccTile(
                  currentAssets:
                      context.watch<SimulationProvider>().currentAssets,
                  onTap: () {}),
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
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: mHeight * 0.01175,
              ),
              getHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHistory() {
    switch (current) {
      case 0:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetsHistoryTile(
                date: '18 March 2024, 20:22',
                description: 'Withdraw FD in CIMB (3.65 %, 6 months)',
                isProfit: true,
                price: 7000,
              ),
              AssetsHistoryTile(
                date: '16 March 2024, 20:22',
                description: 'Make FD in CIMB (3.65 %, 6 months)',
                isProfit: false,
                price: 7000,
              ),
              AssetsHistoryTile(
                date: '14 March 2024, 17:30',
                description: 'Close Trade GLG 1.12 Shares',
                isProfit: true,
                price: 172.27,
              ),
              AssetsHistoryTile(
                date: '12 March 2024, 14:15',
                description: 'Deposit 10000 into CIMB Bank',
                isProfit: false,
                price: 10000,
              ),
              AssetsHistoryTile(
                date: '11 March 2024, 12:27',
                description:
                    'Mar 24 Mothly Repayment for Mutiara Ville @ Cyberjaya',
                isProfit: false,
                price: 58500,
              ),
              AssetsHistoryTile(
                date: '9 March 2024, 14:30',
                description: 'Buy GLG 1.12 Shares',
                isProfit: false,
                price: 112.75,
              ),
              AssetsHistoryTile(
                date: '9 March 2024, 08:15',
                description: 'Down Payment for Mutiara Ville @ Cyberjaya',
                isProfit: false,
                price: 58500,
              ),
            ],
          ),
        );
      case 1:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetsHistoryTile(
                date: '11 March 2024, 12:27',
                description:
                    'Mar 24 Mothly Repayment for Mutiara Ville @ Cyberjaya',
                isProfit: false,
                price: 58500,
              ),
              AssetsHistoryTile(
                date: '9 March 2024, 08:15',
                description: 'Down Payment for Mutiara Ville @ Cyberjaya',
                isProfit: false,
                price: 58500,
              ),
            ],
          ),
        );
      case 2:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetsHistoryTile(
                date: '14 March 2024, 17:30',
                description: 'Close Trade GLG 1.12 Shares',
                isProfit: true,
                price: 172.27,
              ),
              AssetsHistoryTile(
                date: '9 March 2024, 14:30',
                description: 'Buy GLG 1.12 Shares',
                isProfit: false,
                price: 112.75,
              ),
            ],
          ),
        );
      default:
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetsHistoryTile(
                date: '18 March 2024, 20:22',
                description: 'Withdraw FD in CIMB (3.65 %, 6 months)',
                isProfit: true,
                price: 7000,
              ),
              AssetsHistoryTile(
                date: '16 March 2024, 20:22',
                description: 'Make FD in CIMB (3.65 %, 6 months)',
                isProfit: false,
                price: 7000,
              ),
            ],
          ),
        );
    }
  }
}
