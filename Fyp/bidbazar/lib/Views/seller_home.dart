import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Seller extends StatelessWidget {
  Seller({super.key});
  static const String routeName = '/sellerScreen';

  @override
  Widget build(BuildContext context) {
    AuthenticateController controller = Get.put(AuthenticateController());

    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: Colors.amber[900],
                    ),
                    backgroundColor: Colors.white,
                    radius: 20,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(
                        "Hello najeeb",
                        style: TextStyle(fontSize: 13, color: Colors.black45),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Clifton block-6",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/profile.jpeg',
                    ),
                    radius: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SearchBar(
                    leading: Icon(Icons.search_rounded),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    ),
                    elevation: MaterialStatePropertyAll(0),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(15, 20))),
                    child: Icon(Icons.filter_list, size: 30),
                  ),
                ),
              ],
            ),
          ],
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
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Icon(Icons.exit_to_app),
                onTap: () => Get.offNamed('loginScreen'),
              ),
              label: 'Exit',
            ),
          ],
        ),
      ),
    );
  }
}
