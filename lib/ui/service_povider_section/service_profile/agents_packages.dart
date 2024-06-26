import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../blocs/user/user_cubit.dart';
import '../../../blocs/user/user_states.dart';
import '../../../model/account_models/agents_packages.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../utils/app_utils.dart';
import '../../location/set_location_screen.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';
import 'edit_package.dart';

class AgentPackagesScreen extends StatelessWidget {
  final String serviceId;
  final String agentId;
  final String serviceType;

  const AgentPackagesScreen({
    super.key,
    required this.serviceId,
    required this.agentId,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: PackagePage(
        serviceId: serviceId,
        agentId: agentId,
        serviceType: serviceType,
      ),
    );
  }
}

class PackagePage extends StatefulWidget {
  final String serviceId;
  final String agentId;
  final String serviceType;

  const PackagePage(
      {super.key,
      required this.serviceId,
      required this.agentId,
      required this.serviceType});

  @override
  State<PackagePage> createState() => _PackagesState(
        serviceId,
        agentId,
      );
}

class _PackagesState extends State<PackagePage> {
  final String serviceId;
  final String agentId;

  List<Packages> packages = [];

  late UserCubit _userCubit;

  _PackagesState(this.serviceId, this.agentId);

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();
    _userCubit.getAgentPackages(serviceId: serviceId, agentId: agentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agent = Provider.of<AccountViewModel>(context, listen: false);

    return BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AgentPackagesLoading) {
            return LoadingPage();
          } else if (state is UserNetworkErr) {
            return Scaffold(
              body: Column(
                children: [
                  SafeArea(
                    child: Container(
                      color: AppColors.cardColor,
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      child: Row(
                        children: [
                          backButton(context),
                          const SizedBox(
                            width: 40,
                          ),
                          CustomText(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            text: '${widget.serviceType} packages'
                                .capitalizeFirstOfEach,
                            weight: FontWeight.w700,
                            size: 18,
                            fontFamily: AppStrings.interSans,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Center(
                            child: Text(
                              'This Agent has\'nt created a package for this service yet. Check back later.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonView(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            expanded: false,
                            borderRadius: 30,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Text(
                              'Return',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserNetworkErrApiErr) {
            return EmptyWidget(
              title: 'Network error',
              description: state.message,
              onRefresh: () => _userCubit.getAgentPackages(
                  serviceId: serviceId, agentId: agentId),
            );
          } else if (state is AgentPackagesLoaded) {
            packages = _userCubit.viewModel.packages;
          }

          return Scaffold(
              body: Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
            child: Column(
              children: [
                SafeArea(
                    child: Container(
                        color: AppColors.cardColor,
                        height: (Platform.isAndroid) ? 0 : 0)),
                Container(
                  padding: const EdgeInsets.only(bottom: 0, top: 30),
                  child: Row(
                    children: [
                      backButton(context),
                      const SizedBox(
                        width: 40,
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: '${widget.serviceType} packages',
                        weight: FontWeight.w700,
                        size: 20,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              text: 'Select package',
                              weight: FontWeight.w500,
                              size: 16,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: screenSize(context).height,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: packages.length,
                                itemBuilder: (__, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      AppNavigator.pushAndStackPage(context,
                                          page: EditPackage(
                                            packageName:
                                                packages[index].name ?? '',
                                            packageDuration:
                                                packages[index].duration ?? '',
                                            packagePrice:
                                                packages[index].price ?? '',
                                            packageDescription:
                                                packages[index].description ??
                                                    '',
                                            packageId:
                                                packages[index].id.toString(),
                                          ));
                                    },
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: ListTile(
                                          leading: ImageView.asset(
                                              AppImages.beginnerPet),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: CustomText(
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                              text: packages[index].name,
                                              weight: FontWeight.w700,
                                              size: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                text:
                                                    'Duration: ${packages[index].duration}',
                                                size: 14,
                                                color: Colors.black,
                                              ),
                                              CustomText(
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                text:
                                                    'Price: NGN ${AppUtils.convertPrice(packages[index].price)}',
                                                size: 14,
                                                color: Colors.black,
                                              ),
                                              CustomText(
                                                textAlign: TextAlign.justify,
                                                maxLines: 2,
                                                text:
                                                    packages[index].description,
                                                size: 14,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
