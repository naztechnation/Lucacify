

import '../agent/agent.dart';
import '../packages/packages.dart';
import '../profile/profile.dart';

class Order {
  int? id;
  String? pickupLocation;
  String? pickupTime;
  String? dropoffTime;
  bool? shouldNotify;
  String? fee;
  String? purchaseId;
  bool? isPaid;
  bool? isAccepted;
  bool? isRejected;
  bool? isOngoing;
  bool? userMarkedDelivered;
  bool? agentMarkedDelivered;
  bool? isCompleted;
  bool? paymentReleased;
  String? dateCreated;
  Profile? profile;
  Agent? agent;
  Package? package;

  Order(
      {this.id,
      this.pickupLocation,
      this.pickupTime,
      this.dropoffTime,
      this.shouldNotify,
      this.fee,
      this.purchaseId,
      this.isPaid,
      this.isAccepted,
      this.isRejected,
      this.isOngoing,
      this.userMarkedDelivered,
      this.agentMarkedDelivered,
      this.isCompleted,
      this.paymentReleased,
      this.dateCreated,
      this.profile,
      this.agent,
      this.package});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupLocation = json['pickup_location'];
    pickupTime = json['pickup_time'];
    dropoffTime = json['dropoff_time'];
    shouldNotify = json['should_notify'];
    fee = json['fee'];
    purchaseId = json['purchase_id'];
    isPaid = json['is_paid'];
    isAccepted = json['is_accepted'];
    isRejected = json['is_rejected'];
    isOngoing = json['is_ongoing'];
    userMarkedDelivered = json['user_marked_delivered'];
    agentMarkedDelivered = json['agent_marked_delivered'];
    isCompleted = json['is_completed'];
    paymentReleased = json['payment_released'];
    dateCreated = json['date_created'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_time'] = this.pickupTime;
    data['dropoff_time'] = this.dropoffTime;
    data['should_notify'] = this.shouldNotify;
    data['fee'] = this.fee;
    data['purchase_id'] = this.purchaseId;
    data['is_paid'] = this.isPaid;
    data['is_accepted'] = this.isAccepted;
    data['is_rejected'] = this.isRejected;
    data['is_ongoing'] = this.isOngoing;
    data['user_marked_delivered'] = this.userMarkedDelivered;
    data['agent_marked_delivered'] = this.agentMarkedDelivered;
    data['is_completed'] = this.isCompleted;
    data['payment_released'] = this.paymentReleased;
    data['date_created'] = this.dateCreated;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.agent != null) {
      data['agent'] = this.agent!.toJson();
    }
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    return data;
  }
}