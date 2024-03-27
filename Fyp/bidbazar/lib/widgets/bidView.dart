import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/data/models/bid_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class BidView extends GetView<BidController> {
   BidView({super.key,required this.items ,required this.buyerId, required this.approvedBid});

  
  final bool approvedBid;
  List<Items> items=[];
  String buyerId;
  // BidController controller=Get.put(BidController());
  String status='';
  RxList<Items>   bisList=<Items>[].obs;


  void approvedBids(){

    items!.forEach((element) {
      if(element.status=="bid approved and closed"){
      bisList.add(element);
      }
    });
  }


  Widget build(BuildContext context) {
    approvedBid? approvedBids():null;
    // print("object");
    // print(controller.bidlist.first.items!.first.product!.name);
    return Scaffold(
      appBar: AppBar(
      
        title:approvedBid?Text("Approved Bids") :Text("BID LOG"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body:   
        
        
        PageStorage(
          bucket: PageStorageBucket(),
          child: controller.obx(
            (_) =>  RefreshIndicator(
              onRefresh: () async{
                await controller.fetchBidItems();
              },
              child: ListView.builder(
                itemCount:approvedBid?bisList.value.length:items.length ,
                itemBuilder: (context, index) {
                  
                  var item=approvedBid?bisList.value[index]: items[index];
                  status=item.status!;
                return Card(
        
                  margin: EdgeInsets.all(5),
                  
               child: Column(
                 children: [
                 Text( "Bid status: "+status),
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
                                        imageUrl: "http://192.168.143.172:4000/api/images/"+item.product!.images!.first,
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
                               AuthenticateController.userdata.first.usertype=='Seller'?
                                 Row(                  children: [
                                  SizedBox(width: 5),
                                
        
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style:  ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orangeAccent[400]
                                      ),
                                      onPressed: () {
                                        print(buyerId);
                                        controller.updateBidStatus(buyerId:buyerId,productId: item.product!.sId!,status: 'bid approved and closed');

                                      // controller.updateBidStatus(buyerId: controller.biditems.value.buyer! ,productId: controller.biditems.value.items![index].product!.sId!,status: 'bid approved and closed');
                                      status='bid approved and closed';
                                    }, icon: Icon(CupertinoIcons.checkmark_alt_circle), label: Text("accept"),),
                                  ),
                                  SizedBox(width: 5),
                                  
                                  Expanded(
                    
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orangeAccent[400]
                                      ),
                                      onPressed: () {
                                      controller.updateBidStatus(buyerId:buyerId,productId:item.product!.sId!,status: 'bid rejected');
                                        status='bid rejected';
        
                                      
                                    }, icon: Icon(Icons.cancel_outlined), label: Text("cancel"),),
                                  ),
                                  SizedBox(width: 5),
            
                                 ],
                                 ):SizedBox(),
                 ],
               ),
                            
              );
                    
              },),
            ),
        
               onEmpty: Text("There is no product to display"),
               onError: (error) => Text("${error}"),
          ),
        ),
    );
      
      
      
      
    
 
        }
}
