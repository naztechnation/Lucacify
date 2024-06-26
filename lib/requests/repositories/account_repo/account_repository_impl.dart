
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
    final map = await Requests().post(AppStrings.otpUrl(url), body: {
      "username": username,
      "email": email,
      "password": password,
      "phone_number": phone,
      "firebase_id": firebaseId,
      "profile_image": profileImage,
      "device_id": profileImage,
    });
    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> loginUser({
    required String username,
    required String password,
  }) async {
    final map = await Requests().post(AppStrings.loginUrl, body: {
      "username_or_email": username,
      "password": password,
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
    final map = await Requests()
        .post(AppStrings.registerUserPetProfileUrl(username: username), body: {
      "type": type,
      "name": petname,
      "gender": gender,
      "breed": breed,
      "size": size,
      "about": about,
      'picture': picture
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
        AppStrings.registerServiceProviderProfileUrl(username: username),
        body: {
          "date_of_birth": dob,
          "name": name,
          "gender": gender,
          "about": about,
          "country": country,
          "city": city,
          // 'picture':
          //     'https://static.standard.co.uk/s3fs-public/thumbnails/image/2019/03/15/17/pixel-dogsofinstagram-3-15-19.jpg?width=1200&height=1200&fit=crop'
          'picture': picture
        });
    return CreateAgents.fromJson(map);
  }

  @override
  Future<AuthData> verifyUser(
      {required String code, required String username}) async {
    final map =
        await Requests().post(AppStrings.verifyUserProfileUrl(username), body: {
      "code": code,
    });

    return AuthData.fromJson(map);
  }

  Future<CreateAgents> servicePetNames(
      {required List<String> petnames,
      required String username,
      required String agentId}) async {
    
    final map =
        await Requests().patch(AppStrings.selectPetTypeUrl(agentId), body: {
      "pet_types": petnames,
    }, headers: {
      'Authorization': AppStrings.token,
      "Content-type": "application/json"
    });
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
      {required String agentId, required String photoUrl, required String idType, required String id}) async {
    final map = await Requests().patch(AppStrings.uploadIdUrl(agentId, id), body: {
      "id_photo": photoUrl,
      "id_type": idType,
    }, headers: {
      'Authorization': AppStrings.token,
      "Content-type": "application/json"
    });
    return AuthData.fromJson(map);
  }
  
   @override
  Future<PetTypesModel> petTypeList()  async {
    final map = await Requests().get(
        AppStrings.petTypesUrl,
       
        headers: {
          'Authorization': AppStrings.token,
        });
    return PetTypesModel.fromJson(map);
  }

   
  
  @override
  Future<AuthData> forgetPassword({required String email}) async {
    final map = await Requests().get(AppStrings.forgotPasswordUrl(email), headers: {
      'Authorization': AppStrings.token,
    });
    return AuthData.fromJson(map);
  }

   @override
  Future<AuthData> resetPassword(
      {required String token, required String password, required String email,}) async {
    final map =
        await Requests().post(AppStrings.resetPasswordUrl(email), body: {
      "code": token,
      "password": password,
    },
    headers: {
      'Authorization': AppStrings.token,
    }
    );

    return AuthData.fromJson(map);
  }
}
