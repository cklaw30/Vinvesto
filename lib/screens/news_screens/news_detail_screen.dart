import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String imagePath;
  final String topic;
  final String author;
  final String date;
  final String content;
  const NewsDetailScreen({super.key, required this.imagePath, required this.topic, required this.author, required this.date, required this.content});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: mHeight * 0.25855,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(imagePath)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: mHeight * 0.03526,
                    bottom: mHeight * 0.03526,
                    left: mWidth * 0.076388,
                    right: mWidth * 0.076388),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic,
                      style: TextStyle(
                          fontSize: mHeight * 0.025855,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: mHeight * 0.017628,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            author,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: mHeight * 0.017628,
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: mHeight * 0.0188,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}