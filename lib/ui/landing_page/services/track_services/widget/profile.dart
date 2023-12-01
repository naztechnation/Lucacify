import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/notfications_pages/chat_pages/chat_page.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../../../../res/app_strings.dart';
import '../../../../../utils/navigator/page_navigator.dart';
import '../../../../video.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/modals.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

Widget serviceProfile(
  BuildContext context, {
  bool hideImage = false,
  required String sellerName,
  required String sellerImage,
  required String sellerId,
  required String userName,
  required String phone,
  required String userType,
  required String customerName,
  required String customerImage,
  required String customerPhone,
  required String customerFireBaseId,
}) {
  return    (userType == 'user') ? Row(
    children: [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: ImageView.network(
            sellerImage,
            height: 80,
            placeholder: AppImages.person,
          ),
        ),
      ),
      Expanded(
        flex: 6,
        child: ListTile(
          title: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: 'Seller',
            weight: FontWeight.w700,
            size: 12,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          subtitle: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: sellerName,
            weight: FontWeight.w700,
            size: 12,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          trailing: (hideImage)
              ? ImageView.svg(AppImages.messageBorder)
              : SizedBox(
                  width: screenSize(context).width * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          _callNumber(phone);
                        },
                        child: ImageView.svg(AppImages.callBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (sellerId == '') {
                              Modals.showToast(
                                  'Can\'t communicate with this agent at the moment. Please');
                            } else {
                              AppNavigator.pushAndStackPage(context,
                                  page: ChatPage(
                                      username: sellerName,
                                      userImage: sellerImage,
                                      uid: sellerId));
                            }
                          },
                          child: ImageView.svg(AppImages.messageBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: VideoCall(
                                  user1: sellerName,
                                  user2: userName,
                                ));
                          },
                          child: ImageView.svg(AppImages.videoBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    ],
  ) : Row(
    children: [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: ImageView.network(
            customerImage,
            height: 80,
            placeholder: AppImages.person,
          ),
        ),
      ),
      Expanded(
        flex: 6,
        child: ListTile(
          title: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: 'Name',
            weight: FontWeight.w700,
            size: 12,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          subtitle: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: customerName.capitalizeFirstOfEach,
            weight: FontWeight.w700,
            size: 12,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          trailing: (hideImage)
              ? ImageView.svg(AppImages.messageBorder)
              : SizedBox(
                  width: screenSize(context).width * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          _callNumber(customerPhone);
                        },
                        child: ImageView.svg(AppImages.callBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (customerFireBaseId == '') {
                              Modals.showToast(
                                  'Can\'t communicate with this buyer at the moment. Please');
                            } else {
                              AppNavigator.pushAndStackPage(context,
                                  page: ChatPage(
                                      username: customerName,
                                      userImage: customerImage,
                                      uid: customerFireBaseId));
                            }
                          },
                          child: ImageView.svg(AppImages.messageBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: VideoCall(
                                  user1: sellerName,
                                  user2: customerName,
                                ));
                          },
                          child: ImageView.svg(AppImages.videoBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    ],
  );
}

_callNumber(String number) async{
  bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
}