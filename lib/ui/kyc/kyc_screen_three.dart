


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/res/enum.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';
import 'kyc_screen_two.dart';
import 'widgets/choice_card.dart';
import 'kyc_screen_four.dart';

class KycScreenThree extends StatefulWidget {
   final String selectedPet;

    KycScreenThree({super.key,  this.selectedPet = ''});

  @override
  State<KycScreenThree> createState() => _KycScreenThreeState();
}

class _KycScreenThreeState extends State<KycScreenThree> {
    PetGenderType _petGenderType = PetGenderType.none;

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          decoration: BoxDecoration(
             
                  ),
          child: Column(children: [
                       SafeArea(child:   SizedBox(height: (Platform.isAndroid) ?44 : 0)),

            backButton(context),
            SizedBox(height: screenSize(context).height * 0.13,),
            ImageView.asset(AppImages.dogWalking),
            SizedBox(height: 55),

            CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  text:'${widget.selectedPet} gender',
                                  weight: FontWeight.w700,
                                  size: 32,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: CustomText(
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      text:'Select gender',
                                      weight: FontWeight.w500,
                                      size: 16,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
              ),
            ),
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              ChoiceCard(_petGenderType == PetGenderType.male, 'Male', () {
                setState(() {
                  _petGenderType = PetGenderType.male;
                });
               }),
                ChoiceCard(_petGenderType == PetGenderType.female, 'Female', () {
                setState(() {
                  _petGenderType = PetGenderType.female;
                });
               })
            ],),

           
            const Spacer(),
          if(_petGenderType != PetGenderType.none)   Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20),
                              child: ButtonView(
                                onPressed: () {
                                  AppNavigator.pushAndStackPage(context, page: KycScreenFour(selectedPet: widget.selectedPet,));
                                },
                                color: AppColors.lightSecondary,
                                borderRadius: 32,
                                borderColor: Colors.white,
                                child:  CustomText(
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      
                                      text: 'Next',
                                      weight: FontWeight.w700,
                                      size: 20,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                             SizedBox(
                  height: 50,
                ),
          ]),
        ),
      ),
    );
  }

  
}