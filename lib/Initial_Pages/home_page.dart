import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sf_app/Initial_Pages/user_profile_page.dart';
import 'package:sf_app/Map/shop_map_info.dart';
import 'package:sf_app/Shared_preference/auth_shared_preference_manager.dart';

import 'package:sf_app/Widget/home_page_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  List<String> buttonList = [
    "Furniture",
    "Electronic",
    "kitchen utensils",
    "Gift Imagez"
  ];

  bool isSelectList = false;
  String? selectedButtonIndex;

  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    sessionManager.updateLastLoggedTimeAndStatus();
  }

  void navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewUserProfilePage(),
      ),
    );
  }

  void navigateToLocOfShop() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ShopMapInfoPage(),
      ),
    );
  }

  navigateToBottomBar(int index) {
    switch (index) {
      case 1:
        navigateToProfile();
        break;
      case 2:
        navigateToLocOfShop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int value) {
              navigateToBottomBar(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: "Shop Info",
              ),
            ],
          ),
          body: Column(
            children: [
              const HomePageWidget(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  focusNode: searchFocusNode,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    hintText: "Search Here",
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: buttonList.length,
                        itemBuilder: (context, index) {
                          if (buttonList.isEmpty) {
                            return const Center(
                              child: Text("No Item seleted Yet"),
                            );
                          }

                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _clickOnListButton(index);
                                  setState(() {
                                    selectedButtonIndex = buttonList[index];
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        selectedButtonIndex == buttonList[index]
                                            ? Colors.red
                                            : Colors.grey[300],
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      buttonList[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: selectedButtonIndex ==
                                                    buttonList[index]
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  addCatData();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addCatData({String? uid}) async {
    List<Map<String, String>> addCat = [
      {"name": "All"},
      {"name": "Furniture"},
      {"name": "Electronic and Electric"},
      {"name": "Kitchen Instrument"},
    ];
    try {
      for (var category in addCat) {
        await FirebaseFirestore.instance.collection("Category").add(category);
      }
      print("Categories added successfully!");
    } catch (e) {
      print("Error adding categories: $e");
    }
  }

  _clickOnListButton(int index) {}
}
