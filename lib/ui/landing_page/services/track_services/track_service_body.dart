import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/location/widgets/map_view.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/location/location.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/location_repo/location_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../service_povider_section/service_profile/service_profile.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/text_edit_view.dart';
import '../pet_profile/pet_profile.dart';
import 'widget/profile.dart';

class TrackServicesBody extends StatefulWidget {
  final String sellerName;
  final String sellerPhoto;
  final String phone;
  final String agentId;
  final String sellerId;
  final String startDate1;
  final String startDate2;
  final String paymentId;
  final String amount;
  final String sessionStatus;
  const TrackServicesBody(
      {super.key,
      required this.sellerName,
      required this.phone,
      required this.agentId,
      required this.sellerId,
      required this.startDate1,
      required this.startDate2,
      required this.paymentId,
      required this.amount,
      required this.sellerPhoto, required this.sessionStatus});

  @override
  State<TrackServicesBody> createState() => _TrackServicesBodyState();
}

class _TrackServicesBodyState extends State<TrackServicesBody> {
  String userType = '';

  getUsername() async {
    userType = await StorageHandler.getUserType();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<UserViewModel>(context, listen: false);
    final user = Provider.of<AccountViewModel>(context, listen: true);

    return MultiBlocProvider(
        providers: [
          BlocProvider<LocationCubit>(
            lazy: false,
            create: (_) => LocationCubit(
                locationRepository: LocationRepositoryImpl(),
                userViewModel:
                    Provider.of<AccountViewModel>(context, listen: false)),
          )
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              serviceProfile(context,
                  sellerName: widget.sellerName,
                  sellerImage: widget.sellerPhoto,
                  sellerId: widget.agentId,
                  userName: user.username,
                  phone: widget.phone),
              if (userType == 'user') ...[
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: AgentProfileScreen(
                          agentId: widget.sellerId,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 60,
                      width: screenSize(context).width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'View profile',
                          weight: FontWeight.w700,
                          size: 12,
                          fontFamily: AppStrings.interSans,
                          color: AppColors.lightSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize(context).width * .05,
                      vertical: 10),
                  width: screenSize(context).width,
                  height: screenSize(context).height * .08,
                  child: ButtonView(
                      expanded: false,
                      onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return PetProfile();
                          })),
                      color: Colors.white,
                      borderColor: Colors.white,
                      child: CustomText(
                        color: Colors.blue,
                        weight: FontWeight.bold,
                        text: 'View pet Profile',
                      )),
                ),
              ],
               const SizedBox(
                height: 20,
              ),
                       DurationTracker(context),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Pick up date and time',
                weight: FontWeight.w700,
                size: 12,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                width: screenSize(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(
                    0xFFF8FAFF,
                  ),
                ),
                child: Row(
                  children: [
                    ImageView.svg(AppImages.calender),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: AppUtils.formatComplexDate(
                          dateTime: widget.startDate1),
                      weight: FontWeight.w600,
                      size: 12,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageView.svg(AppImages.time),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: services
                              .formatDateTimeToAMPM(widget.startDate1 ?? ''),
                          weight: FontWeight.w600,
                          size: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
             

              const SizedBox(
                height: 20,
              ),
              CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Drop off date and time',
                weight: FontWeight.w600,
                size: 12,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                width: screenSize(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(
                    0xFFF8FAFF,
                  ),
                ),
                child: Row(
                  children: [
                    ImageView.svg(AppImages.calender),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: AppUtils.formatComplexDate(
                          dateTime: widget.startDate2),
                      weight: FontWeight.w600,
                      size: 12,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageView.svg(AppImages.time),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: services
                              .formatDateTimeToAMPM(widget.startDate2 ?? ''),
                          weight: FontWeight.w600,
                          size: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 224,
                      width: screenSize(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MapViews(
                        zoom: 11,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ButtonView(
                      onPressed: () {},
                      borderRadius: 30,
                      color: Colors.white,
                      borderColor: Colors.white,
                      child: CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: widget.sessionStatus,
                        weight: FontWeight.w700,
                        size: 12,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text:
                              'Session Paid - NGN ${AppUtils.convertPrice(widget.amount)}',
                          weight: FontWeight.w500,
                          size: 12,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green.shade100),
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: widget.paymentId,
                          weight: FontWeight.w600,
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 180,
              ),
            ],
          ),
        ));
  }

  Widget DurationTracker(BuildContext context) {
    return Container(
      width: screenSize(context).width * .9,
      height: screenSize(context).height * .14,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'Drop off time',
          ),
          Row(
            children: [
              Icon(Icons.timer),
              CustomText(
                text: '06 PM',
                size: 12,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.calendar_month),
              CustomText(
                text: '23rd October, 2023',
                size: 12,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Estimated time for walk - ',
                      size: 10,
                    ),
                    CustomText(
                      text: '2hrs',
                      size: 10,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Remaining time for walk - ',
                      size: 10,
                    ),
                    CustomText(
                      text: '2hrs',
                      size: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
          LinearProgressIndicator(
            value: 0.5, // Represents the progress value (from 0.0 to 1.0)
            minHeight: 8, // Adjust the height of the progress line
            backgroundColor: Colors.grey[300], // Color of the remaining line
            valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue), // Color of the progress line
          ),
        ],
      ),
    );
  }
}
