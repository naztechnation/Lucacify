class UserProfile {
  bool? status;
  Profile? profile;
  List<PetHealthIssue>? petHealthIssue;
  List<PetHealthIssue>? petAllergy;

  UserProfile(
      {this.status, this.profile, this.petHealthIssue, this.petAllergy});

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['pet_health_issue'] != null) {
      petHealthIssue = <PetHealthIssue>[];
      json['pet_health_issue'].forEach((v) {
        petHealthIssue!.add(new PetHealthIssue.fromJson(v));
      });
    }
    if (json['pet_allergy'] != null) {
      petAllergy = <PetHealthIssue>[];
      json['pet_allergy'].forEach((v) {
        petAllergy!.add(new PetHealthIssue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.petHealthIssue != null) {
      data['pet_health_issue'] =
          this.petHealthIssue!.map((v) => v.toJson()).toList();
    }
    if (this.petAllergy != null) {
      data['pet_allergy'] = this.petAllergy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? firebaseId;
  String? deviceId;
  String? phoneNumber;
  String? address;
  String? city;
  String? country;
  String? profileImage;
  bool? isAgent;
  bool? isReachable;
  bool? isVerified;
  bool? hasPets;
  String? createdAt;
  String? updatedAt;
  User? user;

  Profile(
      {this.id,
      this.firebaseId,
      this.deviceId,
      this.phoneNumber,
      this.address,
      this.city,
      this.country,
      this.profileImage,
      this.isAgent,
      this.isReachable,
      this.isVerified,
      this.hasPets,
      this.createdAt,
      this.updatedAt,
      this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    deviceId = json['device_id'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    profileImage = json['profile_image'];
    isAgent = json['is_agent'];
    isReachable = json['is_reachable'];
    isVerified = json['is_verified'];
    hasPets = json['has_pets'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['device_id'] = this.deviceId;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['profile_image'] = this.profileImage;
    data['is_agent'] = this.isAgent;
    data['is_reachable'] = this.isReachable;
    data['is_verified'] = this.isVerified;
    data['has_pets'] = this.hasPets;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;

  User({this.id, this.username, this.email, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class PetHealthIssue {
  int? id;
  String? name;
  String? drug;
  String? prescription;
  Pet? pet;

  PetHealthIssue({this.id, this.name, this.drug, this.prescription, this.pet});

  PetHealthIssue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    drug = json['drug'];
    prescription = json['prescription'];
    pet = json['pet'] != null ? new Pet.fromJson(json['pet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['drug'] = this.drug;
    data['prescription'] = this.prescription;
    if (this.pet != null) {
      data['pet'] = this.pet!.toJson();
    }
    return data;
  }
}

class Pet {
  int? id;
  String? name;
  String? gender;
  String? breed;
  String? size;
  String? about;
  String? picture;
  bool? hasHealthIssues;
  bool? isAllergic;
  bool? isHidden;
  Profile? profile;
  Type? type;

  Pet(
      {this.id,
      this.name,
      this.gender,
      this.breed,
      this.size,
      this.about,
      this.picture,
      this.hasHealthIssues,
      this.isAllergic,
      this.isHidden,
      this.profile,
      this.type});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    breed = json['breed'];
    size = json['size'];
    about = json['about'];
    picture = json['picture'];
    hasHealthIssues = json['has_health_issues'];
    isAllergic = json['is_allergic'];
    isHidden = json['is_hidden'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['breed'] = this.breed;
    data['size'] = this.size;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['has_health_issues'] = this.hasHealthIssues;
    data['is_allergic'] = this.isAllergic;
    data['is_hidden'] = this.isHidden;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Type {
  int? id;
  String? name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}