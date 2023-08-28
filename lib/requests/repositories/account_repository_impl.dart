


import 'dart:io';
import 'dart:math';

import '../../model/account_models/register.dart';
import '../../res/app_strings.dart';
import '../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<UserData> registerUser({required String email,required String password,required String phone})  async{
    final map= await Requests().post(AppStrings.registerUrl,
   
        body: {
          "username": email,
          "password": password,
          "phone_number": phone,
         
        });
    return UserData.fromJson(map);
  }
  
   @override
  Future<UserData> loginUser({required String email,required String password,})  async{
    final map= await Requests().post(AppStrings.loginUrl,
    
        body: {
          "username": email,
          "password": password,
         
        });
    return UserData.fromJson(map);
  }
  
  @override
  Future<UserData> registerUserPetProfile({required String username,required String type, required String petname, required String gender, 
  required String breed, required String size, required String about, required File picture}) async{
    final map= await Requests().post(AppStrings.registerUserPetProfileUrl(username: username),
      files: {'picture': picture},
        body: {
          "type": type,
          "name": petname,
          "gender": gender,
          "breed": breed,
          "size": size,
          "about": about,

         
        });
    return UserData.fromJson(map);
  }
}