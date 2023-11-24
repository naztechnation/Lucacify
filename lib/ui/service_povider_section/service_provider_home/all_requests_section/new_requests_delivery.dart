import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/pet_service_request.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_widgets/ongoing_delivery_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/service_provider/service_provider_cubit.dart';
import '../../../../model/service_provider_models/all_agent_orders.dart';
import '../../../../model/user_models/agent_services_lists.dart';
import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../landing_page/services/track_services/track_services.dart';
import '../../../widgets/modals.dart';
import 'product_shopping_details.dart';
import 'widgets/all_ongoing_page.dart';

class ServiceProviderPetDeliveryHomeBody extends StatefulWidget {
  final ServiceProviderCubit serviceProviderCubit;
  final String agentId;
  ServiceProviderPetDeliveryHomeBody(
      {super.key, required this.serviceProviderCubit, required this.agentId});

  @override
  State<ServiceProviderPetDeliveryHomeBody> createState() =>
      _ServiceProviderPetDeliveryHomeBodyState();
}

class _ServiceProviderPetDeliveryHomeBodyState
    extends State<ServiceProviderPetDeliveryHomeBody>
    with SingleTickerProviderStateMixin {
  bool isServices = true;

  int _currentPage = 0;

  changePage(bool serve) {
    setState(() {
      isServices = serve;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    final userModel = Provider.of<UserViewModel>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Ongoing Services',
                weight: FontWeight.bold,
              ),
              GestureDetector(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: AllOngoingDeliveryScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CustomText(
                    text: 'View all',
                    weight: FontWeight.w400,
                    size: 14,
                    color: AppColors.lightSecondary,
                  ),
                ),
              ),
            ],
          ),
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          SizedBox(
            height: 10,
          ),
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          SizedBox(
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: serviceProvider.onGoingOrdersList.length,
                itemBuilder: (context, index) {
                  return OngoingDeliveryWidget(
                    label: 'Track',
                    services: serviceProvider.onGoingOrdersList[index],
                  );
                }),
          ),
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          SizedBox(
            height: 10,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _buildPageIndicator(serviceProvider.onGoingOrdersList.length),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text:
                    'All new requests (${(isServices) ? serviceProvider.availableServices.length : serviceProvider.order.length})',
                maxLines: 2,
                weight: FontWeight.bold,
                size: 13,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
              child: Row(
                children: [
                  
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        changePage(true);
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                isServices ? Colors.blue : Colors.transparent,
                            width: 5.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'Services',
                        style: TextStyle(
                          color: isServices ? Colors.blue : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      changePage(false);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                !isServices ? Colors.blue : Colors.transparent,
                            width: 5.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'Products',
                        style: TextStyle(
                          color: !isServices ? Colors.blue : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (serviceProvider.availableServices.isEmpty && isServices) ...[
          Container(
              height: 200,
              child: Align(
                  child: Text(
                'You don\'t have an available service',
                style: TextStyle(
                    color: AppColors.lightSecondary,
                    fontWeight: FontWeight.bold),
              ))),
        ] else ...[
          Visibility(
            visible: isServices,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceProvider.availableServices.length,
                itemBuilder: ((context, index) {
                  return _newRequestWidget(context,
                      serviceProvider.availableServices[index], userModel);
                })),
          ),
        ],
        if (serviceProvider.order.isEmpty && !isServices) ...[
          Container(
              height: 200,
              child: Align(
                  child: Text(
                'You don\'t have an available order',
                style: TextStyle(
                    color: AppColors.lightSecondary,
                    fontWeight: FontWeight.bold),
              ))),
        ] else ...[
          Visibility(
            visible: !isServices,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceProvider.order.length,
                itemBuilder: ((context, index) {
                  return _shoppingOrder(context, serviceProvider.order[index]);
                })),
          ),
          if (serviceProvider.pageIndex > 1 && !isServices)
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 18),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: NumberPaginator(
                      numberPages: serviceProvider.pageIndex,
                      onPageChange: (int index) {
                        serviceProvider.setOrderPageIndex(index + 1);
                        widget.serviceProviderCubit.getAllAgentOrder(
                            agentId: widget.agentId,
                            pageIndex: serviceProvider.currentPage.toString());
                      },
                      config: NumberPaginatorUIConfig(
                        buttonSelectedForegroundColor:
                            Theme.of(context).colorScheme.secondary,
                        buttonUnselectedForegroundColor:
                            Theme.of(context).colorScheme.secondary,
                        buttonUnselectedBackgroundColor: AppColors.lightPrimary,
                        buttonSelectedBackgroundColor: AppColors.lightPrimary,
                      ),
                    )),
              ),
            )
        ],
      ],
    );
  }

  Widget _newRequestWidget(
      BuildContext context, AgentServicesListOrders order, userModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          width: 55,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageView.network(
                order.package?.service?.serviceType?.image,
                fit: BoxFit.cover,
              )),
        ),
        title: Row(
          children: [
            Expanded(
              child: CustomText(
                text: '${order.package?.service?.serviceType?.name}',
                weight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: order.isPaid!
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                child: CustomText(
                  text: order.isPaid! ? 'Paid' : 'Not Paid',
                  size: 12,
                  color: order.isPaid! ? Colors.green : Colors.red,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 6,
            ),
            CustomText(
              text: 'Pick up time',
              size: 12,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                ImageView.svg(
                  AppImages.time,
                  height: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  text: userModel.formatDateTimeToAMPM(order.pickupTime),
                  size: 10,
                ),
                const SizedBox(
                  width: 12,
                ),
                ImageView.svg(
                  AppImages.calender,
                  height: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: CustomText(
                    text: AppUtils.formatComplexDateOnly(
                        dateTime: order.pickupTime ?? ''),
                    size: 10,
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ],
        ),
        trailing: Container(
          width: screenSize(context).width * .2,
          child: ButtonView(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   return ServiceRequest();
              // }));

              // if (order.isPaid ?? false) {
              AppNavigator.pushAndStackPage(context,
                  page: TrackServicesScreen(
                    sellerName: order.agent?.name ?? '',
                    phone: order.agent?.profile?.phoneNumber ?? '',
                    serviceOffered:
                        order.package?.service?.serviceType?.name ?? '',
                    agentId: order.agent?.profile?.firebaseId ?? '',
                    sellerId: order.agent?.id.toString() ?? '',
                    startDate1: order.pickupTime ?? '0',
                    startDate2: order.dropoffTime ?? '0',
                    amount: order.fee ?? '',
                    paymentId: order.purchaseId ?? '',
                    sellerImage: order.agent?.picture ?? '',
                    isAcceptedService: order.isAccepted ?? false,
                    isOngoingService: order.isOngoing ?? false,
                    isCompletedService: order.isCompleted ?? false,
                    orderId: order.id.toString(),
                    customerName: order.profile?.user?.username ?? '',
                    customerFireBaseId: order.profile?.firebaseId ?? '',
                    customerImage: order.profile?.profileImage ?? '',
                    customerPhone: order.profile?.phoneNumber ?? '',
                     isRejected: order.isRejected ?? false, 
                     isUserMarkedService: order.userMarkedDelivered ?? false, 
                     isAgentMarkedService: order.agentMarkedDelivered ?? false,
                  ));
              // } else {
              Modals.showToast('This Service has not been paid for.');
              // }
            },
            child: Text(
              'view',
              style: TextStyle(color: Colors.blue),
            ),
            borderRadius: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.blue.shade100,
            expanded: false,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _shoppingOrder(BuildContext context, ShopOrders order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          width: 55,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: ImageView.network(
                order.product!.image,
                fit: BoxFit.cover,
                height: 80,
              )),
        ),
        title: Row(
          children: [
            Expanded(
              child: CustomText(
                text: order.profile?.user?.username
                    .toString()
                    .capitalizeFirstOfEach,
                size: 14,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: order.isPaid!
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                child: CustomText(
                  text: order.isPaid! ? 'Paid' : 'Not Paid',
                  size: 12,
                  color: order.isPaid! ? Colors.green : Colors.red,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomText(
                text: 'Purchase ID  ${order.paymentId}',
                size: 12,
                weight: FontWeight.w400,
              ),
            ),
            CustomText(
              text: '${order.product?.name}',
              size: 12,
              weight: FontWeight.w400,
            ),
          ],
        ),
        trailing: Container(
          width: screenSize(context).width * .2,
          child: ButtonView(
            onPressed: () {
              if (order.isPaid ?? false) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return PurchaseRequest(
                    ownerName: 'Sandra Lee',
                    phoneNumber: '0908765432',
                    productName: '${order.product?.name}',
                    productImage: '${order.product?.image}',
                    quantity: '${order.quantity}',
                    price: '${order.product?.price}',
                    purchaseId: '${order.paymentId}',
                    deliveryDate: today,
                    deliveryLocation: ' ',
                  );
                }));
              } else {
                Modals.showToast('This product  has not been paid for.');
              }
            },
            child: Text(
              'view',
              style: TextStyle(color: Colors.blue),
            ),
            borderRadius: 100,
            color: Colors.blue.shade100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            expanded: false,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator(int length) {
    List<Widget> reverseIndicators = [];
    for (int i = length - 1; i >= 0; i--) {
      reverseIndicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == (length - 1 - i)
                ? AppColors.lightSecondary
                : Colors.grey,
          ),
        ),
      );
    }
    return reverseIndicators;
  }
}