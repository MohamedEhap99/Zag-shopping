import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/networks/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class On_Boarding_Model {
  late final String image;
  late final String title;
  late final String body;

  On_Boarding_Model({
    required this.image,
    required this.title,
    required this.body,
  }
  );
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  var boardController = PageController();

  List<On_Boarding_Model> boarding = [
    On_Boarding_Model(
     image: 'assets/images/onboard1.jpg',
    title:  'Looking For Items',
      body:'Our new service makes it easy for you to \n work anywhere, there are new features\n will really help you. ',
    ),
    On_Boarding_Model(
     image: 'assets/images/onboard2.jpg',
     title: 'Make a Payment',
     body: 'Our new service makes it easy for you to \n work anywhere, there are new features\n will really help you. ',
    ),
    On_Boarding_Model(
     image: 'assets/images/onboard3.jpg',
      title:'Send items',
     body: 'Our new service makes it easy for you to \n work anywhere, there are new features\n will really help you. ',
    ),
  ];

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              onSubmit();
            },
            child: Text(
                'SKIP',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics:BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }

                },
                itemBuilder: (context, index) => buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height:40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrangeAccent,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                  count:boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
    if (isLast) {
      onSubmit();
    }
else{
    boardController.nextPage(
    duration: Duration(
    milliseconds:750,
    ),
    curve:Curves.fastLinearToSlowEaseIn,
    );
    }

                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(On_Boarding_Model model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );

  onSubmit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }


}
