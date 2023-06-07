

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:provider/provider.dart';

import '../../blocs/location/location.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/location_repository_impl.dart';
import '../../res/app_strings.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import 'widgets/location_search.dart';
import 'widgets/map_view.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({Key? key})
      : scale=false, super(key: key);

  const SetLocationScreen.scale({Key? key})
      : scale=true, super(key: key);

  final bool scale;

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
        BlocProvider<LocationCubit>(
          lazy: false,
            create: (_) => LocationCubit(
                locationRepository: LocationRepositoryImpl(),
                userViewModel: Provider.of<UserViewModel>(context, listen: false)),
        )
      ],
      child: Scaffold(
       
        body: Stack(
          children: [
            const MapViews(),
            Container(height: screenSize(context).height,width: screenSize(context).width,color: Colors.black12,),
            Positioned(
              top: 30,
              left: 10,
              child: Row(
                      children: [
              backButton(context),
              const SizedBox(
                width: 40,
              ),
              CustomText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: 'Pick up location',
                weight: FontWeight.w600,
                size: 22,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
                      ],
                    ),
            ),
          ],
        ),
        bottomNavigationBar: Builder(
            builder: (_) {
              if(!widget.scale){
                return const LocationSearch();
              }
              return const SizedBox.shrink();
            }
        ),
        bottomSheet: Builder(
            builder: (_) {
              if(widget.scale){
                return const LocationSearch();
              }
              return const SizedBox.shrink();
            }
        ),
      )
    );
  }

}