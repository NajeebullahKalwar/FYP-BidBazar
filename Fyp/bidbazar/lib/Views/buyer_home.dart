import 'package:bidbazar/Views/buyer/cart.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/widgets/category.dart';
import 'package:bidbazar/Views/home.dart';
import 'package:bidbazar/Views/buyer/message.dart';
import 'package:bidbazar/controllers/auth_controllers.dart';
// import 'package:bidbazar/widgets/wishList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Buyer extends StatelessWidget {
  Buyer({super.key});
  static const String routeName = '/buyerScreen';

  List<Widget> screens = [
    Home(),
    message(),
    Category(),
    Cart(),
    // Library(),
    // hotlist(),
  ];
  AuthenticateController controller = Get.put(AuthenticateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          children: screens,
          index: controller.screenIndex.value,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) {
            controller.screenIndex.value = value;
            // print('naj $value');
          },
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.amber[900]),
          // selectedLabelStyle: TextStyle(
          // ),
          selectedItemColor: Colors.amber[900],
          currentIndex: controller.screenIndex.value,
          selectedFontSize: 10,
          unselectedIconTheme: IconThemeData(
            color: Colors.black54,
          ),
          iconSize: 27,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Add to cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: true,
      //   foregroundColor: Colors.black,
      //   centerTitle: true,
      //   title: Text("Bidbazar"),
      // ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 250,
              width: 200,
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/profile.jpeg',
                  ),
                  radius: 50,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('wish list'),
              selected: true,
              onTap: () {
                WishListController wishListController =
                    Get.put(WishListController());

                wishListController.fetchWishListItems();
                Get.toNamed("wishListScreen");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Item 2'),
              selected: false,
              onTap: () => 1,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text('Exit'),
              selected: false,
              onTap: () => Get.offAllNamed('loginScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
