import 'package:bidbazar/Views/bidviewforbuyer.dart';
import 'package:bidbazar/Views/buyer/cart.dart';
import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/widgets/bidView.dart';
import 'package:bidbazar/widgets/category.dart';
import 'package:bidbazar/Views/home.dart';
import 'package:bidbazar/controllers/auth_controllers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:bidbazar/widgets/wishList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Buyer extends StatelessWidget {
  Buyer({super.key});
  static const String routeName = '/buyerScreen';
  BidController bidController=Get.put(BidController());

  List<Widget> screens = [
    Home(),
    // message(),
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
          // ignore: sort_child_properties_last
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
          unselectedIconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          iconSize: 27,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.message),
            //   label: 'Message',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Add to cart',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'Profile',
            // ),
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
            const SizedBox(
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
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Image.asset(
                    'assets/favourite.png',
                    width: 38,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
              title: const Text('Wish List'),
              // selected: true,
              onTap: () {

                WishListController wishListController =
                    Get.put(WishListController());
                  
                wishListController.fetchWishListItems();
                Get.toNamed("wishListScreen");
              },
            ),
            ListTile(
              // leading: Icon(Icons.receipt),
              leading:  Image.asset(
                fit: BoxFit.contain,
                    'assets/bidIcon.png',
                    width: 35,
                    height: 35,
                  ),
              title: const Text('Bid Log'),
              selected: false,
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => BidViewForBuyer(controller: bidController,),));
                
                // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController, approvedBid:false ),),);
                // bidController.dispose();
              },
            ),
              ListTile(
              // leading: Icon(Icons.receipt),
              leading: Image.asset(
                fit: BoxFit.contain,
                    'assets/approvedBid.png',
                    width: 35,
                    height: 45,
                  ),
              title: const Text('Approved Bid Log'),
              selected: false,
              onTap: () {

                Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(items: bidController.bidItemsList.value.first.items!, approvedBid: true , buyerId: bidController.bidItemsList.first.buyer! , ),));

                // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController , approvedBid: true,
                // ),),);
                // bidController.dispose();
              },
            ),
           
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Exit'),
              selected: false,
              onTap: () {
                
                Get.offAllNamed('loginScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
