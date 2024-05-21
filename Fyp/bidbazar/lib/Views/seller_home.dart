import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/order_controller.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/widgets/bidView.dart';
import 'package:bidbazar/widgets/category.dart';
import 'package:bidbazar/Views/home.dart';
import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/widgets/orderView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Seller extends StatelessWidget {
  Seller({super.key});

  static const String routeName = '/sellerScreen';

  AuthenticateController controller = Get.put(AuthenticateController());
  BidController bidController=Get.put(BidController());
  
  List<Widget> screens = [
    Home(),
    Category(),
    // Library(),
    // hotlist(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
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
          unselectedIconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          iconSize: 27,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
           
          
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
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
              child: const Center(
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
              leading: const Icon(Icons.favorite),
              title: const Text('wish list'),
              // selected: true,
              onTap: ()async {
                WishListController wishListController =
                    Get.put(WishListController());
               await wishListController.fetchWishListItems();
                Get.toNamed("wishListScreen");
              },
            ),
            ListTile(
              leading: Image.asset(
                    'assets/order.png',
                    width: 38,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
              title: const Text('Order Logs'),
              // selected: true,
              onTap: () {
                OrderController orderController =
                    Get.put(OrderController());
                  
                orderController.fetchOrders();
                Navigator.push(context, CupertinoPageRoute( builder: (context) => OrderView(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Recent Bids'),
              selected: false,
              onTap: () async{
                // print("working recent bid :");
                BidController bd=Get.put(BidController());
                await bd.fetchBidItems();
                 Navigator.push(context,CupertinoPageRoute(builder: (context) => BidView(items:bidController.bidItemsList.isEmpty? []: bidController.bidItemsList.first.items!, approvedBid: false , buyerId:bidController.bidItemsList.isEmpty? "": bidController.bidItemsList.first.buyer!),));

                // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController, approvedBid: false),),);
                // bidController.dispose();
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Logout'),
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
        child: const Icon(
          Icons.add,
          size: 42,
        ),
      ),
    );
  }
}
