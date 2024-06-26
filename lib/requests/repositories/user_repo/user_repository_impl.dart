import 'package:petnity/model/account_models/agents_packages.dart';
import 'package:petnity/model/account_models/confirm_payment.dart';
import 'package:petnity/model/user_models/confirm_shop_payment.dart';
import 'package:petnity/model/user_models/create_payment_order.dart';
import 'package:petnity/model/user_models/faq.dart';
import 'package:petnity/model/user_models/get_product_reviews.dart';
import 'package:petnity/model/user_models/notifications.dart';
import 'package:petnity/model/user_models/privacy_policy.dart';
import 'package:petnity/model/user_models/products_detail.dart';
import 'package:petnity/model/user_models/user_shopping_data.dart';

import '../../../model/account_models/auth_data.dart';
import '../../../model/user_models/create_order.dart';
import '../../../model/user_models/gallery_data.dart';
import '../../../model/user_models/order_list.dart';
import '../../../model/user_models/pet_profile_details.dart';
import '../../../model/user_models/pets_profile.dart';
import '../../../model/user_models/reviews_data.dart';
import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/user_models/shopping_lists.dart';
import '../../../model/user_models/user_profile.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<ServiceProvidersList> getServiceProviderList(
      {required String serviceId}) async {
    final map = await Requests()
        .get(AppStrings.getServiceProvidersList(serviceId), headers: {
      'Authorization': AppStrings.token,
    });
    return ServiceProvidersList.fromJson(map);
  }

  @override
  Future<GetServiceTypes> getServiceTypes([String? agentId]) async {
    final map = await Requests().get(
        (agentId == null)
            ? AppStrings.getServiceTypes
            : AppStrings.getIndividualAgentService(agentId),
        headers: {
          'Authorization': AppStrings.token,
        });
    return GetServiceTypes.fromJson(map);
  }

  @override
  Future<ServiceProvidersList> serviceProvided(
      {required List<String> services,
      required String username,
      required String agentId}) async {
    final map = await Requests().patch(AppStrings.selectServiceTypeUrl(agentId),
        body: {
          "service_types": services
        },
        headers: {
          'Authorization': AppStrings.token,
          "Content-type": "application/json"
        });
    return ServiceProvidersList.fromJson(map);
  }

  @override
  Future<GetReviews> getReviews({required String userId}) async {
    final map = await Requests().get(AppStrings.getReviewUrl(userId), headers: {
      'Authorization': AppStrings.token,
    });
    return GetReviews.fromJson(map);
  }

  @override
  Future<GalleryAgents> getGallery({required String userId}) async {
    final map =
        await Requests().get(AppStrings.getGalleryUrl(userId), headers: {
      'Authorization': AppStrings.token,
    });
    return GalleryAgents.fromJson(map);
  }

  @override
  Future<GetAgentsPackages> getAgentPackages(
      {required String agentId, required String serviceId}) async {
    final map = await Requests()
        .get(AppStrings.getAgentPackagesUrl(agentId, serviceId), headers: {
      'Authorization': AppStrings.token,
    });
    return GetAgentsPackages.fromJson(map);
  }

  @override
  Future<PaymentResponse> confirmPayment({
    required String username,
    required String purchaseId,
    required String orderId,
  }) async {
    final map = await Requests()
        .post(AppStrings.confirmPaymentUrl(username, orderId), body: {
      "purchase_id": purchaseId
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return PaymentResponse.fromJson(map);
  }

  @override
  Future<CreateOrder> createOrder(
      {required String packageId,
      required String username,
      required String pickupTime,
      required String dropOffTime,
      required String pickUpLocation}) async {
    final map = await Requests()
        .post(AppStrings.createOrder(packageId, username), body: {
      "pickup_time": pickupTime,
      "dropoff_time": dropOffTime,
      "pickup_location": pickUpLocation,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return CreateOrder.fromJson(map);
  }

  @override
  Future<UserOrderList> orderList({required String username}) async {
    final map = await Requests().get(AppStrings.userOrders(username), headers: {
      'Authorization': AppStrings.token,
    });
    return UserOrderList.fromJson(map);
  }

  @override
  Future<ShoppingList> shoppingList() async {
    final map = await Requests().get(AppStrings.shoppingList, headers: {
      'Authorization': AppStrings.token,
    });
    return ShoppingList.fromJson(map);
  }

  @override
  Future<ShoppingList> agentShoppingList({required String agentId}) async {
    final map = await Requests()
        .get(AppStrings.getAgentsProducts(agentId: agentId), headers: {
      'Authorization': AppStrings.token,
    });
    return ShoppingList.fromJson(map);
  }

  @override
  Future<ProductDetails> productDetails({required String productId}) async {
    final map =
        await Requests().get(AppStrings.productDetailsUrl(productId), headers: {
      'Authorization': AppStrings.token,
    });
    return ProductDetails.fromJson(map);
  }

  @override
  Future<CreatePaymentOrder> createOrderPayment(
      {required String username,
      required String productId,
      required String quantity}) async {
    final map =
        await Requests().post(AppStrings.createOrderPayment(username), body: {
      "product_id": productId,
      "quantity": quantity,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return CreatePaymentOrder.fromJson(map);
  }

  @override
  Future<ConfirmShopPayment> confirmShoppingPayment(
      {required String username,
      required String purchaseId,
      required String shopOrderId}) async {
    final map = await Requests().patch(
        AppStrings.confirmShoppingPaymentUrl(
            username: username, shopOrderId: shopOrderId),
        body: {
          "payment_id": purchaseId
        },
        headers: {
          'Authorization': AppStrings.token,
          "Content-type": "application/json"
        });
    return ConfirmShopPayment.fromJson(map);
  }

  @override
  Future<GetProductReviews> getProductReviews(
      {required String productId}) async {
    final map = await Requests()
        .get(AppStrings.getProductReview(productId: productId), headers: {
      'Authorization': AppStrings.token,
    });
    return GetProductReviews.fromJson(map);
  }

  @override
  Future<AuthData> sendReviews(
      {required String url,
      required String comment,
      required String rating}) async {
    final map =
        await Requests().post(AppStrings.publishProductReview(url: url), body: {
      "rating": rating,
      "comment": comment,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return AuthData.fromJson(map);
  }

  @override
  Future<ServiceProvidersList> getAgentProfile() async {
    final map = await Requests().get(AppStrings.agentProfile, headers: {
      'Authorization': AppStrings.token,
    });
    return ServiceProvidersList.fromJson(map);
  }

  @override
  Future<AuthData> uploadGallery(
      {required String agentId, required String image}) async {
    final map = await Requests()
        .post(AppStrings.uploadAgentGallery(agentId: agentId), body: {
      "image": image,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return AuthData.fromJson(map);
  }

  @override
  Future<UserShopData> shopOrderData({required String username}) async {
    final map = await Requests()
        .get(AppStrings.getUserOrderedProducts(username: username), headers: {
      'Authorization': AppStrings.token,
    });
    return UserShopData.fromJson(map);
  }

  @override
  Future<UserProfile> getUserProfile({required String username}) async {
    final map = await Requests()
        .get(AppStrings.getUserProfile(username: username), headers: {
      'Authorization': AppStrings.token,
    });
    return UserProfile.fromJson(map);
  }

  @override
  Future<PetProfile> getUserPet({required String username}) async {
    final map = await Requests()
        .get(AppStrings.getUserPets(username: username), headers: {
      'Authorization': AppStrings.token,
    });
    return PetProfile.fromJson(map);
  }

  @override
  Future<PetProfileDetails> getUserPetDetails({required String petId}) async {
    final map = await Requests()
        .get(AppStrings.getUserPetDetails(petId: petId), headers: {
      'Authorization': AppStrings.token,
    });
    return PetProfileDetails.fromJson(map);
  }

  @override
  Future<FAQ> getFaq() async {
    final map = await Requests().get(AppStrings.getFaq, headers: {
      'Authorization': AppStrings.token,
    });
    return FAQ.fromJson(map);
  }

  @override
  Future<AuthData> updateNumber({
    required String username,
    required String email,
    required String number,
  }) async {
    final map = await Requests().patch(
      AppStrings.updateNumber(username),
      headers: {
        'Authorization': AppStrings.token,
        "Content-type": "application/json"
      },
      body: {
        "email": email,
        "phone_number": number,
      },
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<PrivacyPolicy> privacy(
     )async {
    final map = await Requests()
        .get(AppStrings.privacy, headers: {
      'Authorization': AppStrings.token,
    });
    return PrivacyPolicy.fromJson(map);
  }
  
  @override
  Future<AuthData> deleteUser({required String username}) async {
    final map = await Requests()
        .patch(AppStrings.deleteUser(username), headers: {
      'Authorization': AppStrings.token,
        "Content-type": "application/json"

    });
    return AuthData.fromJson(map);
  }
  
  @override
  Future<AuthData> reportAgent({required String username, 
  required String description, required String title,required String agentId}) async {
    final map = await Requests()
        .post(AppStrings.reportAgent(username, agentId), body: {
      "title": title,
      "description": description,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return AuthData.fromJson(map);
  }

  
  @override
  Future<AuthData> reportBug({required String username, required String title, required String description}) async {
    final map = await Requests()
        .post(AppStrings.reportBug(username), body: {
      "title": title,
      "description": description,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return AuthData.fromJson(map);
  }

  @override
  Future<Notifications> getNotification({required String username}) async {
    final map = await Requests()
        .get(AppStrings.getUserNotifications(username), headers: {
      'Authorization': AppStrings.token,
    });
    return Notifications.fromJson(map);
  }
}
