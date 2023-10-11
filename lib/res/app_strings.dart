
import 'dart:io';

import '../handlers/app_handlers.dart';

class AppStrings {
  static const String appName = 'Petnity';
  static const String interSans = 'InterSans';
  static const String montserrat = 'Montserrat';



  ///app tokens
  
  static const token = 'Token 2621dfbf5beb58d815961c015b18e79a34a98c4e';

  ///base url
  
  static const String _baseUrl = 'https://api.petnity.official-management.com/';
  


  static const String _androidKey = 'AIzaSyCGhgIA6avmf0LRLakXaAama2vRnBsyL_Q';
  static const String _iosKey = 'Google Maps API key';
  static final locationApiKey = Platform.isAndroid ? _androidKey : _iosKey;

  static const String networkErrorMessage = "Network error, try again later";
  static const String registerUrl = "auth/register";
  static   String resendCodeUrl(String username) => "auth/resend-code/$username";

  static String googlePlaceUrl(String query) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$query&language=en&components=country:ng'
      '&key=$locationApiKey&sessiontoken=${AppHandler.generateUniqueId()}';


  static   String otpUrl(String url) => '${_baseUrl}$url';
  static   String verifyCodeUrl(String username) => '${_baseUrl}auth/resend-code/$username';
  static   String getServiseProvidersList(String serviceId) => '${_baseUrl}users/get-service-agents/$serviceId';
  static   String verifyUserProfileUrl(String username) => '${_baseUrl}auth/verify-profile/$username';
  
  static const String loginUrl = '${_baseUrl}auth/login';
  static const String logoutUrl = '${_baseUrl}auth/logout';
  static const String getServiceTypes = '${_baseUrl}get-service-types';
  static   String uploadIdUrl(String photoId) => '${_baseUrl}auth/upload-id-photo/$photoId';
  static   String getReviewUrl(String userId) => '${_baseUrl}users/get-reviews/$userId';
  static   String selectPetTypeUrl(String agentId) => '${_baseUrl}auth/select-pet-types/$agentId';
  static   String selectServiceTypeUrl(String agentId) => '${_baseUrl}auth/select-service-types/$agentId';
  static String petHealthStatusUrl({String? petId}) => '${_baseUrl}pets/add-health-issue/$petId';
  static String petAlergeyDataUrl({String? petId = '2'}) => '${_baseUrl}pets/add-allergies/$petId';
  static   String petHealthUrl({required url}) =>'${_baseUrl+url}';
   static String registerUserPetProfileUrl({required username}) =>
      '${_baseUrl}pets/add-pet/$username';
     static String registerServiceProviderProfileUrl({required username}) =>
      '${_baseUrl}auth/create-agent/$username'; 
 
}

