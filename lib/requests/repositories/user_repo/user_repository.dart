 
 
import '../../../model/user_models/reviews_data.dart';
import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/service_type.dart';


abstract class UserRepository {
  Future<ServiceProvidersList> getServiceProviderList({
    required String serviceId,
    
    });   

    Future<GetServiceTypes> getServiceTypes(); 
    Future<GetReviews> getReviews({required String userId}); 
 Future<ServiceProvidersList> serviceProvided({required List<String> services,required String username,required String agentId});   

}