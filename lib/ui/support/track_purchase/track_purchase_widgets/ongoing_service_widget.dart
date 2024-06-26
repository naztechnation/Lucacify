import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../handlers/secure_handler.dart';
import '../../../../model/user_models/order_list.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../res/app_colors.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../landing_page/services/track_services/track_services.dart';
import '../../../notfications_pages/chat_pages/chat_page.dart';
import '../../../video.dart';
import '../../../widgets/modals.dart';
import '../widget/progressbar.dart';

class OngoingServiceWidget extends StatefulWidget {
  final UserOrders allOrders;

  final String label;
  OngoingServiceWidget({this.label = 'Details', required this.allOrders});

  @override
  State<OngoingServiceWidget> createState() =>
      _OngoingServiceWidgetState(allOrders);
}

class _OngoingServiceWidgetState extends State<OngoingServiceWidget> {
  final UserOrders allOrders;

  _OngoingServiceWidgetState(this.allOrders);

  String username = '';

  getUsername() async {
    username = await StorageHandler.getUserName();
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<UserViewModel>(context, listen: false);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ImageView.network(
                      allOrders.agent?.picture,
                       height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )),
                Container(
                  width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allOrders.agent?.profile?.user?.username ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        allOrders.package?.service?.serviceType?.name ?? '',
                      )
                    ],
                  ),
                ),
                Container(
                  width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drop off time',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(services
                          .formatDateTimeToAMPM(allOrders.dropoffTime ?? ''))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total time: ${services.calculateTimeDifferenceInHours(allOrders.pickupTime ?? '0', allOrders.dropoffTime ?? '0')} Hrs',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                    'Time remaining : ${services.calculateRemainingTimeInHours(allOrders.dropoffTime ?? '0')} Hrs',
                    style: TextStyle(fontSize: 10)),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ProgressBar(
              remainingTime: double.parse(
                  (services.calculateRemainingTimeInHours(
                              allOrders.dropoffTime ?? '') ==
                          'Elapsed'
                      ? '0.0'
                      : services.calculateRemainingTimeInHours(
                          allOrders.dropoffTime ?? ''))),
              totalTime: double.parse(services.calculateTimeDifferenceInHours(
                  allOrders.pickupTime ?? '0', allOrders.dropoffTime ?? '0')),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Contact ${allOrders.package?.service?.serviceType?.name ?? ''}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _callNumber(
                              allOrders.agent?.profile?.phoneNumber ?? '');
                        },
                        child: ImageView.svg(AppImages.callBorder)),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (allOrders.agent?.profile?.firebaseId == '' ||
                              allOrders.agent?.profile?.firebaseId == null) {
                            Modals.showToast(
                                'Can\'t communicate with this agent at the moment. Please');
                          } else {
                            AppNavigator.pushAndStackPage(context,
                                page: ChatPage(
                                    agentName: allOrders.agent?.profile?.user?.username ?? '',
                                    userImage: allOrders.agent?.picture ?? '',
                                    uid: allOrders.agent?.profile?.firebaseId ??
                                        '', customerName: allOrders.profile?.user?.username ?? '',));
                          }
                        },
                        child: ImageView.svg(AppImages.messageBorder)),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          AppNavigator.pushAndStackPage(context,
                              page: VideoCall(
                                customerName: allOrders.profile?.user?.username ?? '',
                                agentName: allOrders.agent?.profile?.user?.username ?? '',
                              ));
                        },
                        child: ImageView.svg(AppImages.videoBorder)),
                  ],
                ),
                Container(
                  width: screenSize(context).width * .23,
                  child: ButtonView(
                    color: AppColors.lightSecondary,
                    onPressed: () {
                      AppNavigator.pushAndStackPage(context,
                          page: TrackServicesScreen(
                            agentName: allOrders.agent?.profile?.user?.username ?? '',
                            phone: allOrders.agent?.profile?.phoneNumber ?? '',
                            serviceOffered:
                                allOrders.package?.service?.serviceType?.name ??
                                    '',
                            agentId: allOrders.agent?.profile?.firebaseId ?? '',
                            sellerId: allOrders.agent?.id.toString() ?? '',
                            startDate1: allOrders.pickupTime ?? '0',
                            startDate2: allOrders.dropoffTime ?? '0',
                            amount: allOrders.fee ?? '',
                            paymentId: allOrders.purchaseId ?? '',
                            sellerImage: allOrders.agent?.picture ?? '',
                            isAcceptedService: allOrders.isAccepted ?? false,
                            isOngoingService: allOrders.isOngoing ?? false,
                            isCompletedService: allOrders.isCompleted ?? false,
                            orderId: allOrders.id.toString(),
                            customerName: allOrders.profile?.user?.username ?? '',
                            customerPhone: allOrders.profile?.phoneNumber ?? '',
                            customerImage: allOrders.profile?.profileImage ?? '',
                            customerFireBaseId: allOrders.profile?.firebaseId ?? '',
                            isRejected: allOrders.isRejected ?? false,
                            isUserMarkedService:
                                allOrders.userMarkedDelivered ?? false,
                            isAgentMarkedService:
                                allOrders.agentMarkedDelivered ?? false,
                          ));
                    },
                    child: Text(widget.label, style: TextStyle(color: Colors.white),),
                    borderRadius: 30,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _callNumber(String number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
  }
}
