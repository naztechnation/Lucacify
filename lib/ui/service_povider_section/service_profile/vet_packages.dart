import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/model/user_models/vet_services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../blocs/service_provider/service_provider.dart';
import '../../../../../handlers/secure_handler.dart';
import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../../res/app_colors.dart';
import '../../../../../res/app_constants.dart';
import '../../../../../utils/app_utils.dart';
import '../../../res/app_strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import '../../widgets/text_edit_view.dart';

class VetPackages extends StatelessWidget {
  final String agentId;
  const VetPackages({
    Key? key,
    required this.agentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: VetBooking(
        agentId: agentId,
      ),
    );
  }
}

class VetBooking extends StatefulWidget {
  final String agentId;

  VetBooking({super.key, required this.agentId});
  @override
  State<VetBooking> createState() => _VetBookingState();
}

class _VetBookingState extends State<VetBooking> {
  final _amountController = TextEditingController();
  late ServiceProviderCubit _serviceProviderCubit;

  VetsServices? vetServices;

  String amount = "";

  String agentId = "";
  String vetServiceId = "";

  bool isLoading = true;
  bool isLive = false;

  getAgentId() async {
    agentId = await StorageHandler.getUserId();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();

    setState(() {
      isLoading = true;
    });

    await _serviceProviderCubit.vetServices(agentId: widget.agentId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAgentId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: backButton(context),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Editing Pricing',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'InterSans'),
          ),
        ),
        body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
            listener: (context, state) {
          if (state is CreateServiceNetworkErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is CreateServiceNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is VetsServicesLoaded) {
            vetServices = state.vetService;

            amount = vetServices?.vetService?.price ?? '';
            _amountController.text = vetServices?.vetService?.price ?? '';
            vetServiceId = vetServices?.vetService?.id.toString() ?? '';

            isLive = vetServices?.vetService?.isLive ?? false;
          } else if (state is EditPackageLoaded) {
            Modals.showToast(state.data.message ?? '');
          }
        }, builder: (context, state) {
          return (isLoading)
              ? LoadingPage()
              : Container(
                  height: screenSize(context).height,
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.scaffoldColor, Colors.red.shade50],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // color: Colors.white.withOpacity(0.8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (isLive) ...[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: 'Vets Package',
                                            weight: FontWeight.w700,
                                            size: 14,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Align(
                                                  child: Container(
                                                    width: 130,
                                                    height: 130,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(150),
                                                        child:
                                                            ImageView.network(
                                                          vetServices
                                                                  ?.vetService
                                                                  ?.serviceType
                                                                  ?.image ??
                                                              '',
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CustomText(
                                                  text:
                                                      'Service Amount: NGN ${AppUtils.convertPrice(vetServices?.vetService?.price ?? '0')}',
                                                  size: 13,
                                                  weight: FontWeight.w600,
                                                  color:
                                                      AppColors.lightSecondary,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomText(
                                            text: 'Service Types',
                                            weight: FontWeight.w700,
                                            size: 14,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width:
                                                screenSize(context).width * .9,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                            child: ListView.builder(
                                              itemCount: vetServices?.vetService
                                                      ?.sessionTypes?.length ??
                                                  0,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return buildSessionTypeWidget(
                                                    index,
                                                    '',
                                                    vetServices
                                                            ?.vetService
                                                            ?.sessionTypes?[
                                                                index]
                                                            .name ??
                                                        '',
                                                    context);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          CustomText(
                                            text: 'Contact Medium',
                                            weight: FontWeight.w700,
                                            size: 14,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width:
                                                screenSize(context).width * .9,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                            child: ListView.builder(
                                              itemCount: vetServices
                                                      ?.vetService
                                                      ?.contactMediums
                                                      ?.length ??
                                                  0,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return buildSessionTypeWidget(
                                                    index,
                                                    '',
                                                    vetServices
                                                            ?.vetService
                                                            ?.contactMediums?[
                                                                index]
                                                            .name ??
                                                        '',
                                                    context);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextEditView(
                                            controller: _amountController,
                                            borderRadius: 20,
                                            readOnly: false,
                                            boxHeight: 8,
                                            keyboardType: TextInputType.number,
                                            borderColor: Colors.white,
                                            filled: true,
                                            fillColor: Colors.white,
                                            isDense: true,
                                            hintText: 'Input New Price',
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 30.0, horizontal: 5),
                                            child: ButtonView(
                                              processing:
                                                  state is EditPackageLoading,
                                              onPressed: () {
                                                if (_amountController.text !=
                                                    amount) {
                                                  _serviceProviderCubit
                                                      .editVetPackage(
                                                          agentId: agentId,
                                                          price:
                                                              _amountController
                                                                  .text
                                                                  .trim(),
                                                          serviceId:
                                                              vetServiceId);
                                                  // Modals.showToast(_amountController.text);
                                                } else {
                                                  Modals.showToast(
                                                      'Please enter a price different from the former');
                                                }
                                              },
                                              color: AppColors.lightSecondary,
                                              borderRadius: 22,
                                              child: CustomText(
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                text: 'Update Pricing',
                                                weight: FontWeight.w400,
                                                size: 15,
                                                fontFamily:
                                                    AppStrings.interSans,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ] else ...[
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.5,
                                        child: Center(
                                          child: Text(
                                            'No available packages for you.',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ]))));
        }));
  }

  Widget buildSessionTypeWidget(
      int index, String image, String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              fontFamily: 'InterSans'),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider()
      ],
    );
  }
}
