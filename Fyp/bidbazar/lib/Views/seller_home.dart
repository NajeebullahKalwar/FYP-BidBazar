import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/widgets/bidView.dart';
import 'package:bidbazar/widgets/category.dart';
import 'package:bidbazar/Views/home.dart';
import 'package:bidbazar/Views/buyer/message.dart';
import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Seller extends StatelessWidget {
  Seller({super.key});
  static const String routeName = '/sellerScreen';

  List<Widget> screens = [
    Home(),
    message(),
    Category(),
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
          },
          showUnselectedLabels: false,
          // backgroundColor: Colors.white12,
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.amber[900]),
          selectedItemColor: Colors.amber[900],
          currentIndex: controller.screenIndex.value,
          selectedFontSize: 10,
          // showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,

          // landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
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
              activeIcon: SizedBox(),
              icon: SizedBox(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
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
              leading: Icon(Icons.sell),
              title: Text('Bid Accept'),
              selected: false,
              onTap: () {
                    BidController bidController=Get.put(BidController());

                Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController),),);
                // bidController.dispose();
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text('Exit'),
              selected: false,
              onTap: () {
                Get.offAllNamed('loginScreen');
              },
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        enableFeedback: true,
        backgroundColor: Colors.orange[800],
        // shape: CircleBorder(
        //     side: BorderSide(
        //         color: const Color.fromARGB(96, 255, 255, 255),
        //         width: 5,
        //         strokeAlign: 0)),

        onPressed: () {
          Get.toNamed("addProduct");
        },
        child: Icon(
          Icons.add,
          size: 42,
        ),
      ),
    );
  }
}
