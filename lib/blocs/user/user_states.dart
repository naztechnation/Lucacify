import 'package:equatable/equatable.dart';
import 'package:petnity/model/user_models/notifications.dart';
import 'package:petnity/model/user_models/shopping_lists.dart';

import '../../model/account_models/agents_packages.dart';
import '../../model/account_models/auth_data.dart';
import '../../model/account_models/confirm_payment.dart';
import '../../model/user_models/confirm_shop_payment.dart';
import '../../model/user_models/create_order.dart';
import '../../model/user_models/create_payment_order.dart';
import '../../model/user_models/faq.dart';
import '../../model/user_models/gallery_data.dart';
import '../../model/user_models/get_product_reviews.dart';
import '../../model/user_models/order_list.dart';
import '../../model/user_models/pet_profile_details.dart';
import '../../model/user_models/pets_profile.dart';
import '../../model/user_models/privacy_policy.dart';
import '../../model/user_models/products_detail.dart';
import '../../model/user_models/reviews_data.dart';
import '../../model/user_models/service_provider_lists.dart';
import '../../model/user_models/service_type.dart';
import '../../model/user_models/user_profile.dart';
import '../../model/user_models/user_shopping_data.dart';



abstract class UserStates extends Equatable {
  const UserStates();
}

class InitialState extends UserStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class ServiceProviderListLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class ServicesLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ServicesLoaded extends UserStates {
  final GetServiceTypes services;
  const ServicesLoaded(this.services);
  @override
  List<Object> get props => [services];
}

class UploadAgentGalleryLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class UploadAgentGalleryLoaded extends UserStates {
  final AuthData gallery;
  const UploadAgentGalleryLoaded(this.gallery);
  @override
  List<Object> get props => [gallery];
}
class ServiceProviderListLoaded extends UserStates {
  final ServiceProvidersList userData;
  const ServiceProviderListLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class ReviewLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ReviewLoaded extends UserStates {
  final GetReviews reviews;
  const ReviewLoaded(this.reviews);
  @override
  List<Object> get props => [reviews];
}
class GalleryLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class GalleryLoaded extends UserStates {
  final GalleryAgents galleryAgents;
  const GalleryLoaded(this.galleryAgents);
  @override
  List<Object> get props => [galleryAgents];
}

class AgentPackagesLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class AgentPackagesLoaded extends UserStates {
  final GetAgentsPackages packages;
  const AgentPackagesLoaded(this.packages);
  @override
  List<Object> get props => [packages];
}

class ConfirmPaymentLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ConfirmPaymentLoaded extends UserStates {
  final PaymentResponse packages;
  const ConfirmPaymentLoaded(this.packages);
  @override
  List<Object> get props => [packages];
}

class CreateOrderLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class CreateOrderLoaded extends UserStates {
  final CreateOrder createOrder;
  const CreateOrderLoaded(this.createOrder);
  @override
  List<Object> get props => [createOrder];
}

class OrderListLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class OrderListLoaded extends UserStates {
  final UserOrderList orderList;
  const OrderListLoaded(this.orderList);
  @override
  List<Object> get props => [orderList];
}

class ShoppingListLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ShoppingListLoaded extends UserStates {
  final ShoppingList shoppingList;
  const ShoppingListLoaded(this.shoppingList);
  @override
  List<Object> get props => [shoppingList];
}

class ProductDetailsLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ProductDetailsLoaded extends UserStates {
  final ProductDetails productDetails;
  const ProductDetailsLoaded(this.productDetails);
  @override
  List<Object> get props => [productDetails];
}

class ProductOrderLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ProductOrderLoaded extends UserStates {
  final CreatePaymentOrder createPaymentOrder;
  const ProductOrderLoaded(this.createPaymentOrder);
  @override
  List<Object> get props => [createPaymentOrder];
}

class ConfirmShoppingOrderLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ConfirmShoppingOrderLoaded extends UserStates {
  final ConfirmShopPayment confirmPaymentOrder;
  const ConfirmShoppingOrderLoaded(this.confirmPaymentOrder);
  @override
  List<Object> get props => [confirmPaymentOrder];
}

class GetProductReviewsLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class GetProductReviewsLoaded extends UserStates {
  final GetProductReviews getAgentPayment;
  const GetProductReviewsLoaded(this.getAgentPayment);
  @override
  List<Object> get props => [getAgentPayment];
}

class PostProductReviewsLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class PostProductReviewsLoaded extends UserStates {
  final AuthData postReview;
  const PostProductReviewsLoaded(this.postReview);
  @override
  List<Object> get props => [postReview];
}

class UserShopListLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class UserProfileLoaded extends UserStates {
  final UserProfile username;
  const UserProfileLoaded(this.username);
  @override
  List<Object> get props => [username];
}

class PetProfileLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class PetProfileLoaded extends UserStates {
  final   PetProfile petData;
  const PetProfileLoaded(this.petData);
  @override
  List<Object> get props => [petData];
}

class PetProfileDetailsLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class PetProfileDetailsLoaded extends UserStates {
  final   PetProfileDetails petData;
  const PetProfileDetailsLoaded(this.petData);
  @override
  List<Object> get props => [petData];
}
class UserProfileLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class UserShopListLoaded extends UserStates {
  final UserShopData userShopData;
  const UserShopListLoaded(this.userShopData);
  @override
  List<Object> get props => [userShopData];
}

class FaqLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class FaqLoaded extends UserStates {
  final FAQ faq;
  const FaqLoaded(this.faq);
  @override
  List<Object> get props => [faq];
}

class ChangeNumberLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ChangeNumberLoaded extends UserStates {
  final AuthData number;
  const ChangeNumberLoaded(this.number);
  @override
  List<Object> get props => [number];
}

class PrivacyLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class PrivacyLoaded extends UserStates {
  final PrivacyPolicy privacyPolicy;
  const PrivacyLoaded(this.privacyPolicy);
  @override
  List<Object> get props => [privacyPolicy];
}

class DeleteUserLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class DeleteUserLoaded extends UserStates {
  final AuthData deleteUserData;
  const DeleteUserLoaded(this.deleteUserData);
  @override
  List<Object> get props => [deleteUserData];
}

class ReportBugLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ReportBugLoaded extends UserStates {
  final AuthData reportBug;
  const ReportBugLoaded(this.reportBug);
  @override
  List<Object> get props => [reportBug];
}

class ReportAgentLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ReportAgentLoaded extends UserStates {
  final AuthData reportAgent;
  const ReportAgentLoaded(this.reportAgent);
  @override
  List<Object> get props => [reportAgent];
}

class NotificatonsLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class NotificatonsLoaded extends UserStates {
  final Notifications notifications;
  const NotificatonsLoaded(this.notifications);
  @override
  List<Object> get props => [notifications];
}

class UserNetworkErr extends UserStates {
  final String? message;
  const UserNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class UserNetworkErrApiErr extends UserStates {
  final String? message;
  const UserNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CreateOrderNetworkErr extends UserStates {
  final String? message;
  const CreateOrderNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CreateOrderNetworkErrApiErr extends UserStates {
  final String? message;
  const CreateOrderNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}



