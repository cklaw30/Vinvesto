import 'package:demo_google/componenets/my_linechart.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellStockScreen extends StatefulWidget {
  const SellStockScreen({super.key});

  @override
  State<SellStockScreen> createState() => _SellStockScreenState();
}

int current = 5;
int current2 = 1;
double _currentSliderRM = 172.27;
int remove = 5;

class _SellStockScreenState extends State<SellStockScreen> {
  @override
  Widget build(BuildContext context) {
    final sp = Provider.of<SimulationProvider>(context, listen: false);
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
    int remove_count =
        stockYList.length - (stockYList.length * remove / 6).ceil();
    List<String> durations = ['1D', '1W', '1M', '6M', '1Y', 'MAX'];
    stockYList.removeRange(0, remove_count);
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Row(
          children: [
            Icon(
              Icons.wallet,
              size: mHeight * 0.04701,
            ),
            SizedBox(
              width: mWidth * 0.01273,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Savings',
                  style: TextStyle(fontSize: mHeight * 0.014103),
                ),
                Text(
                  'RM ${sp.currentAssets.toString()}',
                  style: TextStyle(fontSize: mHeight * 0.01645),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: mHeight * 0.009401,
                        bottom: mHeight * 0.009401,
                        left: mWidth * 0.02037,
                        right: mWidth * 0.02037),
                    child: Container(
                      height: mHeight * 0.05876,
                      width: mWidth * 0.12731,
                      padding: EdgeInsets.only(
                          top: mHeight * 0.009401,
                          bottom: mHeight * 0.009401,
                          left: mWidth * 0.02037,
                          right: mWidth * 0.02037),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset('images/google.png'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GLG',
                        style: TextStyle(
                            fontSize: mHeight * 0.02115,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Google',
                        style: TextStyle(fontSize: mHeight * 0.014103),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: mWidth * 0.02037),
                child: Text(
                  'RM154.19',
                  style: TextStyle(
                      fontSize: mHeight * 0.02821, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: mWidth * 0.02037),
                child: Text(
                  'Owned: 1.12 Shares',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: mHeight * 0.0188,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: double.infinity,
                height: mHeight * 0.35256,
                child: MyLineChart(
                  yList: stockYList,
                  data: true,
                ),
              ),
              Container(
                height: mHeight * 0.05876,
                width: double.infinity,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: durations.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                            remove = (index + 1);
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: mHeight * 0.009401,
                              bottom: mHeight * 0.009401,
                              left: mWidth * 0.02037,
                              right: mWidth * 0.02037),
                          width: mWidth * 0.12731,
                          height: mHeight * 0.0235,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: current == index
                                ? Border.all(
                                    color: Colors.blue.shade100,
                                    width: mWidth * 0.00509)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              durations[index],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: mHeight * 0.04701,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: mHeight * 0.009401,
                    bottom: mHeight * 0.009401,
                    left: mWidth * 0.02037,
                    right: mWidth * 0.02037),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.green.shade50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // amount label
                    Padding(
                      padding: EdgeInsets.only(
                          left: mWidth * 0.06111,
                          top: mHeight * 0.014103,
                          bottom: mHeight * 0.009401),
                      child: Text(
                        'Amount',
                        style: TextStyle(fontSize: mHeight * 0.02115),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                          left: mWidth * 0.06111, right: mWidth * 0.06111),
                      width: double.infinity,
                      height: mHeight * 0.05876,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Container(
                              width: mWidth * 0.10185,
                              height: mHeight * 0.05876,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(child: Text('RM '))),

                          // text field filling down payment price
                          Expanded(
                            child: Padding(
                                padding:
                                    EdgeInsets.only(left: mWidth * 0.03056),
                                child: Text(
                                  '172.27',
                                  style: TextStyle(fontSize: mHeight * 0.0188),
                                )),
                          ),

                          Container(
                              width: mWidth * 0.25463,
                              height: mHeight * 0.05876,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                  child: Text(
                                      '${(_currentSliderRM / 154.19).toStringAsFixed(2)} Shares'))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.0235,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: mHeight * 0.05288,
              ),
              GestureDetector(
                onTap: () {},
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
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    'Close Trade',
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
