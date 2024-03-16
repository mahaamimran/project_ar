import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';

class PremiumFeaturesScreen extends StatelessWidget {
  const PremiumFeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColorBackground,
      appBar: AppBar(
        title: Text(
          'Premium Features',
          style: CustomTextStyles.headingText1,
        ),
        backgroundColor: ColorConstants.blackColorBackground,
      ),
      body: Center(
          child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Image as the base layer of the stack
              Image.asset('assets/ticket.png'),
              // Positioned widget allows precise positioning of the text over the image
              Positioned(
                top: 20, // Adjust the position as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Unlimited Albums',
                      style: CustomTextStyles.headingText2,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create as many \nalbums as you want',
                          style: CustomTextStyles.headingText3,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 10), // Adjust spacing as needed
                        Text(
                          'Rs.1700',
                          style: CustomTextStyles.headingText1,
                        ),
                      ],
                    ),
                    // line in betweenn
                    Container(
                      height: 0.5,
                      width: 30,
                      color: ColorConstants.whiteColor,
                    ),
                   // SizedBox(height: screenHeight*0.05,),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Buy', style: CustomTextStyles.headingText1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.redColor,
                        minimumSize:
                            Size(250, 50), // Adjust button size as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
