import 'package:demo_google/componenets/news_normal_tile.dart';
import 'package:demo_google/componenets/news_stock_tile.dart';
import 'package:demo_google/componenets/news_trending_tile.dart';
import 'package:demo_google/screens/news_screens/news_detail_screen.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int current = 0;
  List<String> items = [
    'Latest News',
    'Property Guides',
    'Stock Ideas',
  ];

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mHeight * 0.06581, 
        title: Text("Financial News", style: TextStyle(fontSize: mHeight * 0.03290, fontWeight: FontWeight.bold),)),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // search bar
            Padding(
              padding: EdgeInsets.only(
                  left: mWidth * 0.03056,
                  right: mWidth * 0.03056,
                  top: mHeight * 0.009401,
                  bottom: mHeight * 0.009401),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    contentPadding: EdgeInsets.only(
                        top: mHeight * 0.014102,
                        bottom: mHeight * 0.014102,
                        left: mWidth * 0.03056,
                        right: mWidth * 0.03056)),
              ),
            ),

            // select news horizontal bar
            Padding(
              padding: EdgeInsets.only(bottom: mHeight * 0.009401),
              child: SizedBox(
                height: mHeight * 0.04701,
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
                              left: 16,),
                          width: mWidth * 0.28009,
                          height: mHeight * 0.05288,
                          decoration: BoxDecoration(
                            color: current == index ? Colors.blue.shade900 : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              items[index], style: TextStyle(fontSize: mHeight * 0.01645, color: current == index ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),

            getNews(mHeight: mHeight, mWidth: mWidth)
          ],
        ),
      )),
    );
  }

  Widget getNews({required double mHeight, required double mWidth}) {
    switch (current) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: mWidth * 0.04074, bottom: mHeight * 0.009401),
              child: Text(
                'TRENDING',
                style: TextStyle(fontSize: mHeight * 0.02585, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: mHeight * 0.28205,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 5,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return NewsTrendingTile(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(imagePath: 'images/news1.jpeg', author: 'Lynelle Tham', date: '16 Mar 2024', topic: 'No Link Between Falling Ringgit And Profligate Money Printing, Says Economist', content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. d ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis au",))),);
                },
              ),
            ),
            SizedBox(
              height: mHeight * 0.3278842650809134,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return NewsNormalTile(author: 'Bernama', date: '15 Mar 2024', imagePath: 'images/news2.jpg', title: 'Ringgit closes lower alongside regional currencies', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(imagePath: 'images/news2.jpg', author:  'Bernama', date: '15 Mac 2024', topic: 'Ringgit closes lower alongside regional currencies', content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",))),);
                },
              ),
            ),
          ],
        );

      case 1:
        return SizedBox(
          height: mHeight * 0.6557685301618268,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 20,
            itemBuilder: (context, index) {
              return NewsNormalTile(author: 'FMT Reporters', title: 'Making A Down Payment In Malaysia: Here Are 6 Things To Expect', date: '9 Mar 2024', imagePath: 'images/news3.png', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(imagePath: 'images/news3.png', author:  'FMT Reporter', date: '9 Mac 2024', topic: 'Making A Down Payment In Malaysia. Here Are 6 Things To Expect', content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",))),);
            },
          ),
        );

      default:
      return SizedBox(
          height: mHeight * 0.6557685301618268,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 20,
            itemBuilder: (context, index) {
              return NewsStockTile();
            },
          ),
        );
    }
  }
}
