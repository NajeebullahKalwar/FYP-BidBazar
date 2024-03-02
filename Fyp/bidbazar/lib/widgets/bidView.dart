import 'package:bidbazar/controllers/bidController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class BidView extends GetView<BidController> {
   BidView({super.key,required this.controller });

   BidController controller;

  // BidController controller=Get.put(BidController());

  @override
  Widget build(BuildContext context) {
    // print("object");
    // print(controller.bidlist.first.items!.first.product!.name);
    return Scaffold(
      appBar: AppBar(
      
        title: Text("BID LOG"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body:   
        
        
        controller.obx(
          (_) =>  RefreshIndicator(
            onRefresh: () async{
              await controller.fetchBidItems();
            },
            child: ListView.builder(
              itemCount:controller.biditems.value.items!.length ,
              itemBuilder: (context, index) {
                var item=controller.biditems.value.items![index];
              return Card(
                margin: EdgeInsets.all(0),
                
             child: Column(
               children: [
                 ListTile(
                  visualDensity: VisualDensity(vertical: 4),
                                contentPadding: EdgeInsets.all(5),
                    
                                title: Text(
                                  
                                  item.product!.name.toString().toLowerCase() 
                                      
                                ),
                                subtitle: Text(
                                  maxLines: 1,
                                  "Rs"+
                                  item.product!.price.toString()
                                  // style: TextStyle(),
                                ),
                                
                                leading: Container(
                                  width: Get.width * 0.24,
                                  // height: Get.height*1,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(0),
                                        bottom: Radius.circular(0)
                                        ),
                                    child: CachedNetworkImage(
                                      // fit: BoxFit.scaleDown,
                                      fit: BoxFit.contain,
                  
                                      // width: Get.width * .25,
                                      imageUrl: "http://192.168.18.172:4000/api/images/"+item.product!.images!.first,
                                          // controller
                                              // .cartlist[index].product!.images!.first
                                              // .toString(),
                                    ),
                                    // "https://i.postimg.cc/nzdgXrFC/anh-nhat-Pd-ALQmf-Eqv-E-unsplash.jpg"
                                  ),
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        
                                        "Bid Price: "+item.bidprice.toString()),
                                    ),
          
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              // Spacer(),
                               Row(children: [
                                SizedBox(width: 5),
          
                                Expanded(
                                  child: ElevatedButton.icon(
                                    style:  ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[400]
                                    ),
                                    onPressed: () {
                                    
                                  }, icon: Icon(CupertinoIcons.checkmark_alt_circle), label: Text("accept"),),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                  
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[400]
                                    ),
                                    onPressed: () {
                                    
                                  }, icon: Icon(Icons.cancel_outlined), label: Text("cancel"),),
                                ),
                                SizedBox(width: 5),
          
                               ],)
               ],
             ),
                          
            );
                  
            },),
          ),

       onEmpty: Text("There is no product to display"),
       onError: (error) => Text("${error}"),
        ),
    );
      
      
      
      
    
 
        }
}
