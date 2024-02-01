import 'dart:convert';

import 'package:petnity/model/user_models/id_types.dart';
import 'package:petnity/ui/widgets/modals.dart';

import '../../../model/account_models/create_agent.dart';
import '../../../model/account_models/auth_data.dart';
import '../../../model/account_models/pet_profile.dart';
import '../../../model/account_models/pet_types.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<AuthData> registerUser(
      {required String email,
      required String password,
      required String username,
      required String url,
      required String firebaseId,
      required String deviceId,
      required String profileImage,
      required String phone}) async {
    var payload = {
      'username': username,
      'email': email,
      'phoneNumber': phone,
      'firebaseId': firebaseId,
      'deviceId': deviceId,
      'password': password
    };

    final map = await Requests()
        .post(AppStrings.otpUrl(url), body: json.encode(payload), headers: {
      'Content-type': 'application/json',
    });
    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> loginUser({
    required String email,
    required String password,
  }) async {
    var payload = {'emailOrUsername': email, 'password': password};
    final map = await Requests()
        .post(AppStrings.loginUrl, body: json.encode(payload), headers: {
      'Content-type': 'application/json',
    });
    return AuthData.fromJson(map);
  }


  @override
Future<AuthData> verifyUser(
    {required String code, required String email}) async {

  var payload =    {
    "email": email,
    "code": code
};
  final map =
      await Requests().patch(AppStrings.verifyUserProfileUrl,body: payload, headers: {
      'Content-type': 'application/json',
    });

  return AuthData.fromJson(map);
}
@override
Future<AuthData> logoutUser({
  required String username,
  required String password,
}) async {
  final map = await Requests().post(AppStrings.logoutUrl, body: {
    "username": username,
    "password": password,
  });
  return AuthData.fromJson(map);
}

@override
Future<PetProfile> registerUserPetProfile(
    {required String username,
    required String type,
    required String petname,
    required String gender,
    required String breed,
    required String size,
    required String about,
    required String picture}) async {

      var payload = {
    "type": type,
    "name": petname,
    "gender": gender,
    "breed": breed,
    "size": size,
    "about": about,
    'picture': picture
  };
  final map = await Requests()
      .post(AppStrings.registerUserPetProfileUrl, body: json.encode(payload), headers: {
      'Content-type': 'application/json',
    });
  return PetProfile.fromJson(map);
}

Future<AuthData> sendPetHealth(
    {required String name,
    required String drug,
    required String prescription,
    required String url}) async {
  final map = await Requests().post(AppStrings.petHealthUrl(url: url), body: {
    "name": name,
    "drug": drug,
    "prescription": prescription,
  });
  return AuthData.fromJson(map);
}

@override
Future<CreateAgents> registerServiceProviderProfile(
    {required String username,
    required String dob,
    required String name,
    required String gender,
    required String country,
    required String city,
    required String about,
    required String picture}) async {
  final map = await Requests().post(
      AppStrings.registerServiceProviderProfileUrl,
      body: {
        "dateOfBirth": dob,
        "name": name,
        "gender": gender,
        "about": about,
        "country": country,
        "city": city,
        
        'picture': picture
      });
  return CreateAgents.fromJson(map);
}



Future<CreateAgents> servicePetNames(
    {required List<String> petnames,
    required String username,
    required String agentId}) async {
  final map =
      await Requests().patch(AppStrings.selectPetTypeUrl, body: {
    "petTypes": petnames,
  }, );
  return CreateAgents.fromJson(map);
}

@override
Future<AuthData> resendCode({required String username}) async {
  final map = await Requests().get(AppStrings.otpUrl(username), headers: {
    'Authorization': AppStrings.token,
  });
  return AuthData.fromJson(map);
}

@override
Future<AuthData> uploadPhotoUrl(
    {required String agentId,
    required String photoUrl,
    required String idType,
    required String id}) async {
  final map =
      await Requests().patch(AppStrings.uploadIdUrl, body: {
    "idPhoto": photoUrl,
    "idType": idType,
  }, );
  return AuthData.fromJson(map);
}

@override
Future<PetTypesModel> petTypeList() async {
  final map = await Requests().get(AppStrings.petTypesUrl, );
  return PetTypesModel.fromJson(map);
}

@override
Future<AuthData> forgetPassword({required String email}) async {
  final map =
      await Requests().get(AppStrings.forgotPasswordUrl(email), headers: {
    'Authorization': AppStrings.token,
  });
  return AuthData.fromJson(map);
}

@override
Future<AuthData> resetPassword({
  required String token,
  required String password,
  required String email,
}) async {
  final map = await Requests().post(AppStrings.resetPasswordUrl(email), body: {
    "code": token,
    "password": password,
  }, headers: {
    'Authorization': AppStrings.token,
  });

  return AuthData.fromJson(map);
}

  @override
  Future<IdTypeList> idTypeList() async {
  final map = await Requests().get(AppStrings.getIdTypeListUrl, );

  return IdTypeList.fromJson(map);
}
}