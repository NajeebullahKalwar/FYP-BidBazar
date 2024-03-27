import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/widgets/bidView.dart';
import 'package:flutter/material.dart';

class BidViewForBuyer extends StatelessWidget {
   BidViewForBuyer({super.key ,required this.controller});
  BidController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black,),
      body:  ListView.builder(
      itemCount: controller.bidItemsList.length,
      itemBuilder:(context, index) {
        return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BidView(approvedBid: false,items: controller.bidItemsList[index].items!,buyerId: controller.bidItemsList[index].buyer!, ), ),),
          child: Card(
            
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                
                children: [
                    Expanded(flex: 3,child: Text(style:TextStyle(fontSize: 16)  , maxLines: 1, "Seller: "+controller.bidItemsList[index].seller!.fullname!.toLowerCase())),
                    Expanded(flex: 1,child: Text("Bids: "+controller.bidItemsList[index].items!.length.toString())),
                    Expanded(flex: 1,child: Icon(Icons.arrow_forward_ios)
                    ),
                ],
              ),
            ),
          ),
        );
      }, 
    
    ),
    );
  }
}