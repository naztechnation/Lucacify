import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/agent/agent.dart';
import '../../../model/services/services.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../landing_page/services/agent_packages.dart';
import '../../landing_page/services/pet_sellers.dart/pet_on_sale.dart';
import '../../landing_page/services/pet_trainers/training_packages.dart';
import '../../landing_page/services/services_lists.dart';
import '../../landing_page/services/vets/vet_service.dart';
import '../../landing_page/services/widgets/gallery_rating_section.dart';
import '../../landing_page/services/widgets/providers_profile_body.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import '../../widgets/profile_image.dart';

class AgentProfileScreen extends StatelessWidget {
  final String? agentId;
  const AgentProfileScreen({
    super.key,
    this.agentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: AgentProfile(
        agentId: agentId,
      ),
    );
  }
}

class AgentProfile extends StatefulWidget {
  final String? agentId;

  AgentProfile({
    super.key,
    this.agentId,
  });

  @override
  State<AgentProfile> createState() => _AgentProfileState();
}

class _AgentProfileState extends State<AgentProfile> {
  final AccountViewModel userViewModel = AccountViewModel();

  Future<bool> onBackPress() {
    Navigator.pop(context);

    return Future.value(false);
  }

  Agent? agents;

  late UserCubit _userCubit;

  List<ServiceTypes> service = [];

  List<Services> services = [];

  String agentId = "";
  String userType = '';
  bool isLoading = false;
  bool isLoading1 = true;

  getAgentId() async {
    userType = await StorageHandler.getUserType();
    if (userType == 'user') {
      agentId = widget.agentId ?? '';
    } else {
      agentId = await StorageHandler.getUserId();
    }

    _userCubit = context.read<UserCubit>();
    setState(() {
      isLoading1 = true;
    });
      await _userCubit.getServiceTypes( );

    await _userCubit.getAgentProfile();
    setState(() {
      isLoading1 = false;
    });
  }

  @override
  void initState() {
    getAgentId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);


    return WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
          body: BlocConsumer<UserCubit, UserStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ServiceProviderListLoading) {
                  return LoadingPage();
                } else if (state is UserNetworkErr) {
                  return Scaffold(
                    body: EmptyWidget(
                      title: 'Network error',
                      description: state.message,
                      onRefresh: () => _userCubit.getAgentProfile(),
                    ),
                  );
                }else if (state is ServicesLoaded) {
                                if (state.services.status!) {
                                  service = _userCubit.viewModel.services;
                                } else {}
                              } else if (state is ServiceProviderListLoaded) {
                                for (var item in state.userData.agents!) {
                                  if (item.id.toString() == agentId) {
                                    agents = item;
                                    break;
                                  }
                                }
                                services = agents?.services ?? [];

                              }  else if (state is UserNetworkErrApiErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _userCubit.getAgentProfile(),
                  );
                } else if (state is ServiceProviderListLoaded) {
                  for (var item in state.userData.agents!) {
                    if (item.id.toString() == agentId) {
                      agents = item;
                      break;
                    }
                  }
                } else if (state is UploadAgentGalleryLoaded) {
                  serviceProvider.resetImage();
                  Modals.showToast(state.gallery.message!);
                  _userCubit.getAgentProfile();
                }

                return Stack(
                  children: [
                    Container(
                      height: screenSize(context).height,
                      width: screenSize(context).width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        AppColors.scaffoldColor,
                        Colors.red.shade50
                      ], begin: Alignment.topRight, end: Alignment.topLeft)),
                      child: Column(
                        children: [
                          SafeArea(
                              child: Container(
                                  color: AppColors.cardColor,
                                  height: (Platform.isAndroid) ? 0 : 0)),
                          Container(
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
                                  text: 'Service profile',
                                  weight: FontWeight.w700,
                                  size: 20,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageView.svg(AppImages.location),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Align(
                                      child: CustomText(
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        text:
                                            '${agents?.city}, ${agents?.country}'
                                                .replaceAll('?', ''),
                                        weight: FontWeight.w300,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ProfileImage(
                                  '${agents?.picture}',
                                  placeHolder: AppImages.person,
                                  radius: 55,
                                  height: 120,
                                  width: 120,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      text:
                                          '${agents?.profile?.user?.username}',
                                      weight: FontWeight.w700,
                                      size: 14,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    agents?.isVerified ?? false
                                        ? ImageView.svg(AppImages.verified)
                                        : SizedBox.shrink(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  text: agents?.isVerified ?? false
                                      ? 'Verified'
                                      : 'Not Verified',
                                  weight: FontWeight.w300,
                                  size: 11,
                                  fontFamily: AppStrings.interSans,
                                  color: agents?.isVerified ?? false
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),

                                ProviderProfileBody(
                                  agents: agents,
                                ),
                                //
                                GalleryRatingSection(userId: agentId),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          bottomNavigationBar: (userType != 'user')
              ? (isLoading1)
                  ? SizedBox.shrink()
                  : Container(
                      height: serviceProvider.imageURl1 == null ? 200 : 370,
                      padding: EdgeInsets.symmetric(vertical: 40),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (serviceProvider.imageURl1 != null)
                            GestureDetector(
                              onTap: () {
                                serviceProvider.resetImage();
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 26.0),
                                  child: const Text(
                                    'Cancel',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: AppColors.lightSecondary,
                                        fontFamily: AppStrings.interSans,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                          if (serviceProvider.imageURl1 != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 130,
                                width: 130,
                                child: ImageView.file(
                                  File(serviceProvider.imageURl1!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: ButtonView(
                              borderRadius: 30,
                              processing: (isLoading),
                              onPressed: () async {
                                String imgUrl = '';
                                if (serviceProvider.imageURl1 != null) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  imgUrl = await serviceProvider.uploadImage(
                                      serviceProvider.imageURl1!.path,
                                      'petnity_service_provider');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (imgUrl != null || imgUrl != "") {
                                    submit(context, imgUrl);
                                  }
                                } else {
                                  serviceProvider.loadImage(
                                      context: context, isProfile: true);
                                }
                              },
                              child: CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                text: (serviceProvider.imageURl1 == null)
                                    ? 'Add photo'
                                    : 'Upload photo',
                                weight: FontWeight.w500,
                                size: 15,
                                // fontFamily: AppStrings.interSans,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BlocConsumer<UserCubit, UserStates>(
                            listener: (context, state) {
                              if (state is ServicesLoaded) {
                                if (state.services.status!) {
                                  service = _userCubit.viewModel.services;
                                } else {}
                              } else if (state is ServiceProviderListLoaded) {
                                for (var item in state.userData.agents!) {
                                  if (item.id.toString() == agentId) {
                                    agents = item;
                                    break;
                                  }
                                }
                                services = agents?.services ?? [];
                              } else if (state is UserNetworkErrApiErr) {
                              } else if (state is UserNetworkErr) {}
                            },
                            builder: (context, state) => GestureDetector(
                              onTap: () {
       
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                    isDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        height: screenSize(context).height * .8,
                                        child: SingleChildScrollView(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            CustomText(
                                              size: 16,
                                              text: 'Your Active Services',
                                              weight: FontWeight.bold,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            (state is ServiceProviderListLoading)
                                                ? Align(
                                                    child: ImageView.asset(
                                                    AppImages.loading,
                                                    height: 50,
                                                  ))
                                                : ServicesList(
                                                    services: services,
                                                    isAgent: true,
                                                    agentId: agentId,
                                                  ),
                                          ],
                                        )),
                                      );
                                    });
                              },
                              child: CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                text: 'Edit Packages',
                                weight: FontWeight.w400,
                                size: 15,
                                fontFamily: AppStrings.interSans,
                                color: AppColors.lightSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
              : SizedBox.shrink(),
        ));
  }

  submit(BuildContext context, String imageURl) async {
    setState(() {
      isLoading = true;
    });
    await _userCubit.uploadGallery(agentId: agentId, image: imageURl);

    setState(() {
      isLoading = false;
    });
  }
}

openServices(String services, BuildContext context) {
  switch (services) {
    case '':
      break;
    case 'dog walkers':
      AppNavigator.pushAndStackPage(context,
          page: PackagesScreen(
            serviceId:
                Provider.of<AccountViewModel>(context, listen: false).serviceId,
            agentId:
                Provider.of<AccountViewModel>(context, listen: false).agentId2,
          ));

      break;
    case 'pet date':
      break;
    case 'dog sitters':
      AppNavigator.pushAndStackPage(context,
          page: PackagesScreen(
            serviceId:
                Provider.of<AccountViewModel>(context, listen: false).serviceId,
            agentId:
                Provider.of<AccountViewModel>(context, listen: false).agentId2,
          ));

      break;
    case 'trainer':
      AppNavigator.pushAndStackPage(context, page: TrainingScreen());
      break;
    case 'vets':
      AppNavigator.pushAndStackPage(context, page: VetService());
      break;
    case 'grooming':
      break;
    case 'breeders':
      break;
    case 'pet sellers':
      AppNavigator.pushAndStackPage(context, page: PetsOnSale());

      break;
    case 'boarding':
      break;
    case 'pet care givers':
      break;

    default:
    //AppNavigator.pushAndStackPage(context, page: SetLocationScreen());
  }
}
