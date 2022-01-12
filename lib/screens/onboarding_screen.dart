import 'package:e_commerce/network/cache_helper.dart';
import 'package:e_commerce/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constans.dart';
import '../constans.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarder = [
    BoardingModel(
      image: 'assets/images/ecommerce.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/ecommerce.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/ecommerce.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];
  void Submit(){
    CacheHelper.saveData(key: "onboarding", value: true).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                Submit();
              },
              child: Text("SKIP",style: TextStyle(color: Colors.grey,fontSize: 20),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    itemCount: boarder.length,
                    controller: boardController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int index) {
                      if (index == boarder.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarder[index]))),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect:  ExpandingDotsEffect(
                    dotColor: Colors.blueGrey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 3,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarder.length,
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blueGrey,
                  onPressed: () {
                    if (isLast) {
                      Submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 500,
              width: 500,
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      );
}
