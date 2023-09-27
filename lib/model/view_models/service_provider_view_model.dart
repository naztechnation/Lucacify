import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/app_colors.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class ServiceProviderViewModel extends BaseViewModel {
  String _username = '';
  String _serviceProviderCountry = '';
  String _serviceProviderState = '';
  String _serviceProviderCity = '';

  String _petTypeIndex = '';
  String _serviceProviderName = '';
  String _serviceProviderGender = '';
  String _serviceProviderAge = '';

  String _aboutServiceProvider = '';
  File? _imageURl;
  File? _imageURl2;
  List<String> _selectedServiceItems = [];
  List<String> _selectedPetType = [];

  ImagePicker picker = ImagePicker();

  Services _selectedService = Services.none;

  setServiceProviderAge(String age) {
    _serviceProviderAge = age;
    setViewState(ViewState.success);
  }

  Future<String> showDatePickerDialog(BuildContext context) async {
    String age = '';
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.lightSecondary, // header background color
              onPrimary: AppColors.lightPrimary, // header text color
              onSurface: AppColors.lightSecondary, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.lightSecondary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      String formattedDate = "${selectedDate.toLocal()}".split(' ')[0];

      setServiceProviderAge(formattedDate);

      age = serviceProviderAge;
    }

    return age;
  }

  setServiceProviderName(String name) {
    _serviceProviderName = name;
    setViewState(ViewState.success);
  }

 

  setServiceProviderGender(String serviceGender) {
    _serviceProviderGender = serviceGender;
    setViewState(ViewState.success);
  }

  setPetTypeIndex(String petTypeIndex) {
    _petTypeIndex = petTypeIndex;
    setViewState(ViewState.success);
  }

  addService(String service) {
    if (_selectedServiceItems.contains(service)) {
      _selectedServiceItems.remove(service);
    } else {
      _selectedServiceItems.add(service);
    }
    setViewState(ViewState.success);
  }

   addPetServiceType(String service) {
    if (_selectedPetType.contains(service)) {
      _selectedPetType.remove(service);
    } else {
      _selectedPetType.add(service);
    }
    setViewState(ViewState.success);
  }

  setAboutServiceProvider(String about) {
    _aboutServiceProvider = about;
    setViewState(ViewState.success);
  }

  setCityServiceProvider(String city) {
    _serviceProviderCity = city;
    setViewState(ViewState.success);
  }

  setCountryServiceProvider(String country) {
    _serviceProviderCountry = country;
    setViewState(ViewState.success);
  }

  setStateServiceProvider(String state) {
    _serviceProviderState = state;
    setViewState(ViewState.success);
  }

 

  Future<void> setUserData({required String username}) async {
    _username = username;
    setViewState(ViewState.success);
  }

  loadImage(BuildContext context, bool isSecondUpload) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);

                      if(isSecondUpload){
                        _imageURl2 = File(image!.path);
                      }else{
                        _imageURl = File(image!.path);
                      }
                  
                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                   if(isSecondUpload){
                        _imageURl2 = File(image!.path);
                      }else{
                        _imageURl = File(image!.path);
                      }
                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }

  Future<void> setSelectedService(Services selectedService) async {
    _selectedService = selectedService;
    setViewState(ViewState.success);
  }


  Services get selectedService => _selectedService;

  
  String get username => _username;
  String get serviceProviderCity => _serviceProviderCity;
  String get serviceProviderCountry => _serviceProviderCountry;
  String get serviceProviderState => _serviceProviderState;
  String get petTypeIndex => _petTypeIndex;
  String get serviceProviderName => _serviceProviderName;
  String get servicesProviderGender => _serviceProviderGender;
  String get serviceProviderAge => _serviceProviderAge;
  List<String> get selectedServiceItems => _selectedServiceItems;
  List<String> get selectedPetType => _selectedPetType;
  String get aboutServiceProvider => _aboutServiceProvider;
  File? get imageURl => _imageURl;
  File? get imageURl2 => _imageURl2;
}