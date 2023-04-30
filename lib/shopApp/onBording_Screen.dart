import 'package:api_project/shopApp/Login_Block/Login_Shopping_App.dart';
import 'package:api_project/shopApp/another%20thinks/CacheHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class onBordingScreen extends StatefulWidget {
   onBordingScreen({Key? key}) : super(key: key);

  @override
  State<onBordingScreen> createState() => _onBordingScreenState();
}

class _onBordingScreenState extends State<onBordingScreen> {
   var BordController = PageController();

  List<BoardingModel> Boarding = [
    BoardingModel(image: 'PhotosApp/m2.jpeg', title: 'On Board 1 Title ', body: 'On Body 1 Title'),
    BoardingModel(image: 'PhotosApp/b1.webp', title: 'On Board 2 Title ', body: 'On Body 2 Title'),
    BoardingModel(image: 'PhotosApp/m6.avif', title: 'On Board 3 Title ', body: 'On Body 3 Title'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: submit, child:const Text('SKIP',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),) ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(child: PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index){
                if(index == Boarding.length - 1 ){
                  setState((){
                    isLast = true;
                  });
                  print('last page');
                }else{
                  print('not last page');
                  setState((){
                    isLast = false;
                  });
                }
              },
              controller: BordController,
              itemBuilder: (context,index)=>onbordingItem(Boarding[index]),
              itemCount: Boarding.length,)),
            SizedBox(height: 30,),
            Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                  controller: BordController,
                  count: Boarding.length),
              Spacer(),
              FloatingActionButton(onPressed: (){
                if(isLast){
                  submit();
                }
               else{
                  BordController.nextPage(duration: Duration(
                    milliseconds: 750,
                  ), curve: Curves.fastLinearToSlowEaseIn);
                }
              },child: Icon(Icons.arrow_forward_ios),)
            ],),
          ],
        ),
      ),
    );
  }
  Widget onbordingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(child: Image(image: AssetImage(model.image))),
      //SizedBox(height: 15,),
      Text(model.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),),
      SizedBox(height: 10,),
      Text(model.body,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          fontFamily: 'Helvetica',
        ),),
      SizedBox(height: 50,),

    ],
  );
  void pushAndReplacement(context,widget,)=>Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget) , (route) => false);

  void submit(){
    CacheHelper.saveData(key: 'onBording', value: true).then((value) => {
      if(value){
        pushAndReplacement(context,Login_Page_App_Shopping())
      }
    });
  }
}
