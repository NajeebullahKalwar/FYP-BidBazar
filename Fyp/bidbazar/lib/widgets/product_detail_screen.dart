// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
// import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:bidbazar/widgets/updateproduct.dart';
// import 'package:bidbazar/data/models/wishListModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, this.type});

  static const routeName = "/productDetailScreen";

  BidController bidController=BidController();
  final bidFormKey = GlobalKey<FormState>();
  RxList<DropdownMenuItem> bidMenu = (List<DropdownMenuItem>.of([])).obs;
  RxInt bidPrice = 0.obs;
  final TextEditingController bidPriceController = TextEditingController();
  cartController controller = Get.put(cartController());
  productModel product = Get.arguments[0];
  String? type;
  String userType = Get.arguments[1];
  bool showpersistentFooterButtons=Get.arguments[3]??false;
  // WishListController wishlistController;
 
  // product_controller productController =
  // Get.arguments[2] ?? product_controller();
  // int? index = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
      // bidController.text= product.price.toString();
      
     
     if(bidMenu.isEmpty){ 
      bidPrice.value=product.price!;
      bidMenu.addAll(
      [
        DropdownMenuItem(child: const Text("0% Down"), 
        value: product.price!),
        DropdownMenuItem(child: const Text("5% Down"), 
        value: (product.price!-product.price!*0.05).round()),
        DropdownMenuItem(child: const Text("10% Down"), 
        value: (product.price!-product.price!*0.1).round() ),
        DropdownMenuItem(child: const Text("15% Down"), 
        value: (product.price!-product.price!*0.15).round() ),
        DropdownMenuItem(child: const Text("20% Down"),
         value: (product.price!-product.price!*0.2).round() )
    ]);}
    
    final size=MediaQuery.of(context).size;
    // print("data");
    // productController.isWishListed.value = product.wishlist!;
    return WillPopScope(
      onWillPop: () async {
        print("back button pressed");

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black87),
          centerTitle: true,
          elevation: 0,
          actions: [userType == "Buyer"
                      ?
            SizedBox(
              width: 40,
              height: 40,
              child: SpeedDial(
                
                elevation: 0,
                backgroundColor: Colors.white,
                direction: SpeedDialDirection.down,
                        //  animatedIcon: AnimatedIcons.view_list,
                            overlayColor: Colors.black,
                         overlayOpacity: 0.5,
                             children: [
                          SpeedDialChild(
                            child: const Icon(Icons.call ,), label: 'Phone' ,onTap: () async{
                            AuthenticateController controller =
                                AuthenticateController();
                            var user = await controller
                                .findUserById("655a7e77876d92cd633d5968");
                            final Uri phone = Uri.parse('tel:+92${user.mobile}');
                                if(await canLaunchUrl(phone)){
                           await launchUrl(phone);
                            
                          }  
                           else {
                            Get.snackbar("Could not launch ", user.mobile.toString());
                            // throw 'Could not launch $whatsapp';
                          }
                          },),
                        SpeedDialChild(child: const Icon(Icons.call), label: 'Whatsapp', onTap: ()async {
                           AuthenticateController controller =   AuthenticateController();
                            var user = await controller
                                .findUserById("655a7e77876d92cd633d5968");
                            final Uri whatsapp =
                                Uri.parse('http://wa.me/${user.mobile}');
                           await launchUrl(whatsapp);
                            
                            // throw 'Could not launch $whatsapp';
                        },),
                                    ],
                           child: const Icon(Icons.more_vert_outlined,size: 30, color: Colors.black,),
                        ),
            ):const SizedBox.shrink(),
            const SizedBox(width: 10,)
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              Hero(
                tag: product.sId.toString(),
                child: PageStorage(
                  bucket: PageStorageBucket(),
                  child: Container(
                    height: Get.height * 0.3 / 1.1,
                    child: CarouselSlider.builder(
                      // image slider widget
                      itemCount: product.images?.length,
                      itemBuilder: (context, index, realIndex) {
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "${Api.BASE_URL}/images/${product.images!.elementAt(index)}",
                        );
                      },

                      options: CarouselOptions(
                        // aspectRatio: 16 / 9,

                        // enlargeCenterPage: true,
                        // enlargeFactor: 1,
                        autoPlay: true,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 5,
                thickness: 10,
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  titleTextStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      product.name!.toUpperCase(),
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      const Text("Rs "),
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                //   trailing: userType == "Buyer"
                //       ? InkWell(
                //           onTap: () async {
                //             AuthenticateController controller =
                //                 AuthenticateController();
                //             var user = await controller
                //                 .findUserById("655a7e77876d92cd633d5968");
                //             final Uri whatsapp =
                //                 Uri.parse('http://wa.me/${user.mobile}');
                //             final Uri phone = Uri.parse('tel:+92${user.mobile}');
                //            showModalBottomSheet(
                //             context: context,
                //             builder: (context) {
                //             return Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text("Phone "),
                //               IconButton(onPressed: ()async {
                //                if(await canLaunchUrl(phone)){
                //            await launchUrl(phone);                       
                //           }  
                //            else {
                //             Get.snackbar("Could not launch ", user.mobile.toString());
                //             // throw 'Could not launch $whatsapp';
                //           }
                //               }, icon: Icon(Icons.call),                             
                //                     ),        
                //                      Text("whatsapp "),
                //               IconButton(onPressed: ()async {                               
                //                 // if (await  canLaunchUrl(whatsapp)) {      
                //             await launchUrl(whatsapp);
                //             // launchUrlString(whatsapp.toString());
                //           // } 
                //           //  else {
                //             // Get.snackbar("Could not launch ", user.mobile.toString());
                //             // throw 'Could not launch $whatsapp';
                //           // }                          
                //               }, icon:Icon(Icons.call) )
                //             ]);
                //           },);
                //           // if (await canLaunchUrl(whatsapp)) {      
                //           //   await launchUrl(whatsapp);
                //           // }else if(await canLaunchUrl(phone)){
                //           //  await launchUrl(phone);
                //           // }  
                //           //  else {
                //           //   Get.snackbar("Could not launch ", user.mobile.toString());
                //           //     // throw 'Could not launch $whatsapp';
                //           // }
                //             print(user.mobile);
                //             print(product.user);
                //           },
                //           child: Icon(
                //             Icons.call_outlined,
                //             size: 30,
                //             // color: Colors.amber[900],
                //             fill: 1,
                //           ),
                //         )
                //       :
                //       SizedBox.shrink(),
                //   // trailing: Obx(
                //   //   () => productController.isWishListed.value == false
                //   //       ? Icon(
                //   //           Icons.favorite_outline_rounded,
                //   //           size: 30,
                //   //         )
                //   //       : Icon(
                //   //           Icons.favorite_outlined,
                //   //           size: 30,
                //   //           color: Colors.amber[900],
                //   //           fill: 1,
                //   //         ),
                //   // ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "Specification",
                        style: TextStyle(
                          fontSize: 20,
                          wordSpacing: 2,
                          leadingDistribution:
                              TextLeadingDistribution.proportional,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.specs.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          wordSpacing: 2,
                          leadingDistribution:
                              TextLeadingDistribution.proportional,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              
              

            ],
          ),
        ),


        // persistentFooterAlignment: AlignmentDirectional.centerStart,
       
        persistentFooterButtons:showpersistentFooterButtons==true? [

          
          const SizedBox(
            height: 1,
          ),
          Row(
            children: [
             
              Expanded(
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(Get.width * 0.4, Get.height * 0.1 / 2),
                        backgroundColor: Colors.amber[900],
                      ),
                      onPressed: () {
                        
                        
                                  // productModel Product=productModel(
                                  //   category: product.category,
                                  //   images: product.images,
                                  //   name: product.name,
                                  //   price: int.parse(bidController.text),
                                  //   qty: product.qty??1,
                                  //   sId: product.sId,
                                  //   specs: product.specs,
                                  //   user: product.user,
                                  //   wishlist: product.wishlist,
                               
                                  // );  
                                  // product ;
                                  // Product.price=;

                        userType == "Buyer"
                            ? {
                                controller.addToCart(product, 1),
                                controller.carStateSuccess(),
                                Get.snackbar(
                                    "Add to cart", "Product added to your cart")
                              }
                            : Navigator.push(context,MaterialPageRoute(builder: (context) => UpdateProduct(product:product ,),));

                                
                      },
                      child: userType == "Buyer"
                          ? const Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : const Text(
                              "Edit Product",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      
                    ),
                     SizedBox(
                      width: Get.width * 0.009,
                    ),
                     userType == "Buyer"
                          ?
                     ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(Get.width * 0.4, Get.height * 0.1 / 2),
                        backgroundColor: Colors.amber[900],
                      ),
                      onPressed: () {
                 
                        Get.defaultDialog(
                          confirm:  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(Get.width * 0.4, Get.height * 0.1 / 2),
                        backgroundColor: Colors.amber[900],
                      ),
                      onPressed: () {
                              if(bidFormKey.currentState!
                                .validate()){
                                 bidController.addBid(product.sId!, product.user!, int.parse(bidPriceController.text.toString()) );
                                //  bidPriceController.clear();
                                 Get.back();
                                  // Navigator.pop(context);
                                }
                      },
                      child: const Text(
                              "Confirm",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                        
                    ),
                          title: 'BID',
                          // middleText: 'BID',
                          content:   SingleChildScrollView(
                            
                            child: Column(
                              children: [
                                 Obx(
                                   () =>  DropdownButton(
                                                         enableFeedback: true,
                                                         value:bidPrice.value,
                                                         items:bidMenu,
                                                         onChanged: (value) {
                                                          bidPrice.value=value;
                                                          bidPriceController.text=value.toString();
                                                            // bidController.text=value.toString();
                                                          //  bidController.text = value.toString();
                                                           // print(value);
                                                           // catController.update();
                                                         },
                                                           ),
                                 ),
                                Center(
                                      child: Container(
                                        width: size.width*0.8,
                                        height: size.height*0.1,
                                        child: Form(
                                            key:bidFormKey,
                                            child: customTextFormField(
                                            controller: bidPriceController,
                                            labelText: 'Bid',
                                            prefixIconData: Icons.price_change,
                                                    // hintText: 'Email Address',
                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction.next,
                                            autofocus: false,
                                            validator: (value) {
                                             if(value!.isEmpty){
                                            return "Bid can not be Empty";
                                            }else if((product.price!-product.price!*0.2)>int.parse(bidPriceController.text)){
                                            return "Bid can not lower then 20%";
                                            }else if(int.parse(bidPriceController.text)>product.price!){
                                            return "Bid price can not higher then product price.";
                                      
                                            }else{
                                              return null;
                                            }
                                            
                                            
                                             // return controller.validateEmail(value!);
                                             },
                                             ),
                                          ),
                                      ),
                                    ),
                          
                                    
                              ],
                            ),
                          ),
                        );

                                
                      },
                      child: const Text(
                              "Bid",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ,
                      
                    ):SizedBox.fromSize(size:Size(Get.width*0.4,30)),
                   
                    SizedBox(
                      width: Get.width * 0.001,
                    ),
                    Container(
                      // color: Colors.amber[900],
                      width: Get.width * 0.2 / 1.5,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            WishListController wishListController =
                                Get.put(WishListController());

                            wishListController.Favourite(
                              // add and delete functionality
                              product,
                              product.sId.toString(),
                            );
                            // wishListController.wishlist.add(wishListModel(
                            //   product: product,
                            //   user: AuthenticateController.userdata.first.sId,
                            // ));
                            // wishListController.fetchWishListItems();
                            // productController.productList[index].wishlist =
                            //     await productController.wishlistProduct(
                            //         productId: product.sId!);

                            // productController.isWishListed.value;
                            // print(productController.isWishListed.value);
                          },
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            // fill: 10,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
         
        ]:null,
        // // : null,
        // floatingActionButton: FloatingActionButton.small(
        //   backgroundColor: Colors.orange[800],
        //   onPressed: () {},
        //   child: Icon(Icons.call_outlined),
        // ),
      ),
    );
  }
}
