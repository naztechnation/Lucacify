import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_view.dart';

class ServiceProviderChoice extends StatelessWidget {
   final String imageUrl;
  final double spacing;
  final String serviceName;
  final bool isSelected;
  final bool isShowImage;
  final VoidCallback onPressed;

  ServiceProviderChoice(
      {super.key,
       required this.imageUrl,
      required this.serviceName,
      this.spacing = 0,
      this.isSelected = false,
      required this.onPressed,  this.isShowImage = true});

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: onPressed ,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
        height: 63,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightSecondary : AppColors.cardColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Material(
            borderRadius: BorderRadius.circular(40),
            color: isSelected ? AppColors.lightSecondary : AppColors.cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      textAlign:isShowImage ?  TextAlign.left : TextAlign.center,
                      maxLines: 2,
                      text: serviceName,
                      weight: FontWeight.w400,
                      size: 14,
                      fontFamily: AppStrings.interSans,
                      color: isSelected ? AppColors.lightPrimary : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                if(isShowImage)  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ImageView.network(
                      imageUrl,
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
