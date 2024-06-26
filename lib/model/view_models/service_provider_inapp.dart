import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../res/app_colors.dart';
import '../../res/enum.dart';
import '../order/order.dart';
import '../service_provider_models/all_agent_orders.dart';
import '../user_models/agent_services_lists.dart';
import '../user_models/vet_orders.dart';
import 'base_viewmodel.dart';

class ServiceProviderInAppViewModel extends BaseViewModel {
  ServiceProviderInAppViewModel() {
    filterBankList = _banksAndInstitutions;
  }
  int _selectedIndex = -1;
  int _orderPageNumber = 1;
  String _withDrawableBalance = '0';
  int _currentPage = 1;
  File? _imageURl;
  File? _imageURl1;
  List<ShopOrders> _orders = [];

  List<Order> _availableServices = [];
  List<VetOrders> _vetOrders = [];


  final List<int> _serviceSelectedIndexes = [];
  final List<int> _contactSelectedIndexes = [];
  String _amountController = '';

  final List<String> _servicesType = [];
  final List<int> _servicesIndex = [];

  final List<String> _contactType = [];
  final List<int> _contactIndex = [];

  List<String> filterBankList = [];

  addServiceType(int index, var item, var image) {
  if (_servicesType.length > 3) {
    _serviceSelectedIndexes.clear();
    _servicesType.clear();
    _servicesIndex.clear();

     


  } else {
    String serviceKey = '${item[index]}-${image[index]}';

    if (_serviceSelectedIndexes.contains(index)) {
      _serviceSelectedIndexes.remove(index);

      _servicesType.remove(serviceKey);

      _servicesIndex.remove(index + 1);
    } else {
      _serviceSelectedIndexes.add(index);

      _servicesType.add(serviceKey);
      _servicesIndex.add(index + 1);
    }
  }
  setViewState(ViewState.success);
}

addContactType(int index, var item, var image) {
  if (contactType.length > 3) {
    _contactSelectedIndexes.clear();
    _contactType.clear();
    _contactIndex.clear();

     


  } else {
    String contactKey = '${item[index]}-${image[index]}';

    if (_contactSelectedIndexes.contains(index)) {
      _contactSelectedIndexes.remove(index);

      _contactType.remove(contactKey);

      _contactIndex.remove(index + 1);
    } else {
      _contactSelectedIndexes.add(index);

      _contactType.add(contactKey);
      _contactIndex.add(index + 1);
    }
  }
  setViewState(ViewState.success);
}

  setWithdrawableBalance(String balance){
    _withDrawableBalance = balance;
    setViewState(ViewState.success);

  }
  updateAmountController(String amount) {
    _amountController = amount;

    setViewState(ViewState.success);
  }

  resetBankList() {
    filterBankList = _banksAndInstitutions;

    setViewState(ViewState.success);
  }

  resetImage() {
    _imageURl1 = null;
    _imageURl = null;

    setViewState(ViewState.success);
  }

  setOrderPageIndex(int pageIndex) {
    _currentPage = pageIndex;

    setViewState(ViewState.success);
  }

  searchBank(String query) {
    filterBankList = _banksAndInstitutions
        .where((banks) => banks.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setViewState(ViewState.success);
  }

  setPackageLevelSelectedIndex({required int selectedIndex}) {
    _selectedIndex = selectedIndex;
    setViewState(ViewState.success);
  }

  setAgentOrdersList(AgentsOrderRequests orders) {
    _orders = orders.shopOrders ?? [];
    _orderPageNumber = orders.numPages ?? 1;

    setViewState(ViewState.success);
  }

  setAgentServicesList(AgentServicesList orders) {
    _availableServices = orders.orders ?? [];
    _vetOrders = orders.vetOrders ?? [];
    // _orderPageNumber = orders.numPages ?? 1;

    setViewState(ViewState.success);
  }

  loadImage({required BuildContext context, bool isProfile = false}) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w700)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: AppColors.lightSecondary,
                ),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  if (isProfile) {
                    _imageURl1 = File(image!.path);
                  } else {
                    _imageURl = File(image!.path);
                  }

                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: AppColors.lightSecondary,
                ),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  if (isProfile) {
                    _imageURl1 = File(image!.path);
                  } else {
                    _imageURl = File(image!.path);
                  }
                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }

  Future<String> uploadImage(String imageUrl, String uploadPreset) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/do2z93mmw/upload');

    String image = '';

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageUrl));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final resPonseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(resPonseString);

        image = jsonMap['url'];

        return image;
      }
    } catch (e) {}

    return image;
  }

  int get selectedIndex => _selectedIndex;
  File? get imageURl => _imageURl;
  File? get imageURl1 => _imageURl1;

  String get withdrawableBalance => _withDrawableBalance;

  List<String> get servicesType => _servicesType;
  List<int> get servicesIndex => _servicesIndex;
  List<int> get serviceSelectedIndexes => _serviceSelectedIndexes;

   List<String> get contactType => _contactType;
  List<int> get contactIndex => _contactIndex;
  List<int> get contactSelectedIndexes => _contactSelectedIndexes;

  String get amountController => _amountController;

  List<ShopOrders> get order => _orders;
  List<Order> get availableServices => _availableServices;
  List<VetOrders> get vetOrders => _vetOrders;

  List<String> _banksAndInstitutions = [
    "Access Bank",
    "Accion Microfinance Bank",
    "Advans La Fayette Microfinance Bank",
    "Citibank Nigeria Limited",
    "Coronation Merchant Bank",
    "Covenant Microfinance Bank Ltd",
    "Dot Microfinance Bank",
    "Ecobank Nigeria",
    "Empire Trust Microfinance Bank",
    "FairMoney Microfinance Bank",
    "Fidelity Bank Plc",
    "FBNQuest Merchant Bank",
    "Fina Trust Microfinance Bank",
    "Finca Microfinance Bank Limited",
    "First Bank of Nigeria Limited",
    "First City Monument Bank Limited",
    "Globus Bank Limited",
    "Guaranty Trust Holding Company Plc",
    "Heritage Bank Plc",
    "Infinity Microfinance Bank",
    "Jaiz Bank Plc",
    "Keystone Bank Limited",
    "Kuda Bank",
    "Lotus Bank",
    "Mint Finex MFB",
    "Mkobo MFB",
    "Mutual Trust Microfinance Bank",
    "Nova Merchant Bank",
    "Opay",
    "Optimus Bank Limited",
    "Palmpay",
    "Parallex Bank Limited",
    "Peace Microfinance Bank",
    "Pearl Microfinance Bank Limited",
    "PremiumTrust Bank Limited",
    "Providus Bank Limited",
    "Rand Merchant Bank",
    "Raven bank",
    "Rephidim Microfinance Bank",
    "Rex Microfinance Bank",
    "Shepherds Trust Microfinance Bank",
    "Sparkle Bank",
    "Stanbic IBTC Bank Plc",
    "Standard Chartered",
    "Sterling Bank Plc",
    "SunTrust Bank Nigeria Limited",
    "TajBank Limited",
    "Titan Trust Bank",
    "Union Bank of Nigeria Plc",
    "United Bank for Africa Plc",
    "Unity Bank Plc",
    "VFD Microfinance Bank",
    "Wema Bank Plc",
    "Zenith Bank Plc",
  ];

  int get pageIndex => _orderPageNumber;
  int get currentPage => _currentPage;

  List<Order> get onGoingOrdersList => onGoingServices();

  List<VetOrders> get vetOnGoingOrdersList => vetOnGoingOrdersServices();

  List<Order> onGoingServices() {
    List<Order> list = [];

    for (var order in _availableServices) {
      if (order.isOngoing == true && order.isCompleted != true) {
        list.add(order);
      }
    }

    return list;
  }

  List<VetOrders> vetOnGoingOrdersServices() {
    List<VetOrders> list = [];

    for (var order in _vetOrders) {
      if (order.isOngoing == true && order.isCompleted != true) {
        list.add(order);
      }
    }

    return list;
  }
}
