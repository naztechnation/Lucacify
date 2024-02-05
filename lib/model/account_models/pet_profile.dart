class PetProfile {
  bool? status;
  String? message;
  PetProfileData? data;

  PetProfile({this.status, this.message, this.data});

  PetProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PetProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PetProfileData {
  Pet? pet;

  PetProfileData({this.pet});

  PetProfileData.fromJson(Map<String, dynamic> json) {
    pet = json['pet'] != null ? new Pet.fromJson(json['pet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pet != null) {
      data['pet'] = this.pet!.toJson();
    }
    return data;
  }
}

class Pet {
  List<Null>? healthIssues;
  List<Null>? allergies;
  bool? isHidden;
  String? sId;
  String? user;
  String? type;
  String? name;
  String? gender;
  String? breed;
  String? size;
  String? about;
  String? picture;
  String? createdAt;
  String? updatedAt;

  Pet(
      {this.healthIssues,
      this.allergies,
      this.isHidden,
      this.sId,
      this.user,
      this.type,
      this.name,
      this.gender,
      this.breed,
      this.size,
      this.about,
      this.picture,
      this.createdAt,
      this.updatedAt});

  Pet.fromJson(Map<String, dynamic> json) {
    if (json['healthIssues'] != null) {
      healthIssues = <Null>[];
      json['healthIssues'].forEach((v) {
        // healthIssues!.add(new Null.fromJson(v));
      });
    }
    if (json['allergies'] != null) {
      allergies = <Null>[];
      json['allergies'].forEach((v) {
        // allergies!.add(new Null.fromJson(v));
      });
    }
    isHidden = json['isHidden'];
    sId = json['_id'];
    user = json['user'];
    type = json['type'];
    name = json['name'];
    gender = json['gender'];
    breed = json['breed'];
    size = json['size'];
    about = json['about'];
    picture = json['picture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthIssues != null) {
      // data['healthIssues'] = this.healthIssues!.map((v) => v.toJson()).toList();
    }
    if (this.allergies != null) {
      // data['allergies'] = this.allergies!.map((v) => v.toJson()).toList();
    }
    data['isHidden'] = this.isHidden;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['type'] = this.type;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['breed'] = this.breed;
    data['size'] = this.size;
    data['about'] = this.about;
    data['picture'] = this.picture;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
