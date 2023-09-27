import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';
import '../widgets/modals.dart';
import 'kyc_screen_eight.dart';

class KycScreenSeven extends StatelessWidget {
  final String selectedPet;

  KycScreenSeven({super.key, this.selectedPet = ''});


  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: BlocProvider<AccountCubit>(
          lazy: false,
          create: (_) => AccountCubit(
              accountRepository: AccountRepositoryImpl(),
              viewModel: Provider.of<UserViewModel>(context, listen: false)),
          child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
              if (state is PetProfileLoaded) {
                if(state.userData.status!){
                  AppNavigator.pushAndStackPage(context,
                          page: KycScreenEight(
                           
                          ));
                 Modals.showToast(state.userData.message,
                      messageType: MessageType.success);
                }else{
                   Modals.showToast(state.userData.message,
                      messageType: MessageType.success);
                }
                
              } else if (state is AccountApiErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }else if (state is AccountNetworkErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }
            },
            builder: (context, state) => SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
                backButton(context),
                SizedBox(
                  height: screenSize(context).height * 0.11,
                ),
                CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: 'Upload your ${user.petType} \npicture ',
                  weight: FontWeight.w700,
                  size: 28,
                  fontFamily: AppStrings.montserrat,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 50,
                ),
             if(user.imageURl == null) ... [ClipOval(
                    child: Container(
                        padding: EdgeInsets.all(30),
                        color: AppColors.cardColor,
                        height: 160,
                        width: 160,
                        child: ImageView.asset(
                          AppImages.defaultImage,
                          fit: BoxFit.contain,
                          height: 80,
                          width: 80,
                        ))),] ,
                        if(user.imageURl != null)...[
        
                          ClipOval(
                    child: Container(
                        padding: EdgeInsets.all(0),
                        color: AppColors.cardColor,
                        height: 160,
                        width: 160,
                        child: ImageView.file(File(user.imageURl!.path, ),fit: BoxFit.cover) )),
                            
                        ],
                SizedBox(
                  height: 40,
                ),
             (state is PetProfileLoading) ? SizedBox.shrink():  TextButton(
                  onPressed: () async {
                  user.loadImage(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Select Pet Image'),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFEBF0FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
             if(user.imageURl != null)   Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: ButtonView(
                    onPressed: () {
                      if(user.imageURl != null){

                        _submit(username: user.username, ctx: context, type: user.petTypeIndex, 
                        petname: user.petName, breed: user.petBreed, size: user.petSize, 
                        gender: user.petGender, about: user.aboutPet, picture: user.imageURl!, );
                      }
                    },
                    processing: state is PetProfileLoading,
                    color: AppColors.lightSecondary,
                    borderRadius: 32,
                    borderColor: Colors.white,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      text: 'Submit',
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
              ],
            ),
          ),
        ),
      ),
    ));
  
  }
    _submit({required BuildContext ctx, required String username,required String petname,required String gender,required String breed,required String size,required String type,required String about,required File picture}) {
    
      ctx.read<AccountCubit>().registerUserPetProfile(petname: petname,
       username: username, gender: gender, breed: breed, size: size, type: type, about: about, picture: picture
         );
     
  }
  }