import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/repo/user_repo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  ImageController imgcontroller = ImageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImagesWidget( imgcontroller: imgcontroller,isCnic:false , ),
          ImagesWidget( imgcontroller: imgcontroller,isCnic:true , ),
          // Container(
          //   height: 160,
          //   child: Stack(
          //     children: [
          //       Center(
          //         child: Card(
          //           semanticContainer: true,
          //           child: SizedBox(
          //             width: 170,
          //             height: 120,
          //             child: Column(
          //               // fit: StackFit.loose,
          //               // mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 // const Text("Profile Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey )),
          //                 const SizedBox(height: 20),
          //                 Center(
          //                   child: TextButton.icon(
          //                     onPressed: () {},
          //                     icon: const Icon(
          //                       Icons.upload_file,
          //                       color: Colors.black38,
          //                     ),
          //                     label: Obx(
          //                       () => Text(
          //                         "Images ${imgcontroller.imageList.length}",
          //                         style: const TextStyle(
          //                           fontSize: 20,
          //                           wordSpacing: 2,
          //                           color: Colors.black38,
          //                           leadingDistribution:
          //                               TextLeadingDistribution.proportional,
          //                           fontWeight: FontWeight.w700,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 160,
          //                   child: TextButton(
          //                     onPressed: () {
          //                       imgcontroller.pickImages(); //pick images
          //                       //push user images
          //                       UserRepository().uploadCnicPicture(
          //                           images: imgcontroller.uploadImageList);
          //                       //create user api to insert images in cnic and  profile
          //                       imgcontroller.imageList.clear();
          //                       imgcontroller.uploadImageList.clear();
          //                     },
          //                     style: TextButton.styleFrom(
          //                       shape: const ContinuousRectangleBorder(
          //                         borderRadius: BorderRadius.all(
          //                           Radius.circular(5),
          //                         ),
          //                         side: BorderSide(
          //                           color: Color.fromARGB(255, 158, 158, 158),
          //                         ),
          //                       ),
          //                     ),
          //                     child: const Text(
          //                       'Upload Cnic',
          //                       style: TextStyle(
          //                           color: Colors.black54,
          //                           fontSize: 16.0,
          //                           fontWeight: FontWeight.w700),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       const Align(
          //         alignment: Alignment.topCenter,
          //         child: CircleAvatar(
          //             radius: 24,
          //             backgroundColor: Colors.grey,
          //             child: Icon(
          //               Icons.recent_actors,
          //               size: 34,
          //               color: Colors.black,
          //             )),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ImagesWidget extends StatelessWidget {
   ImagesWidget({
    super.key,
    required this.imgcontroller, required  this.isCnic,
    // required this.imageType
  });

  final ImageController imgcontroller;
  final bool isCnic;
  // final String imageType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        
        children: [

           Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: SizedBox(
              width: 250,
              height:isCnic?400 : 360,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 400,
                      // color: Colors.black,
                      height: 250,
                    child:
                    isCnic==true?AuthenticateController.userdata.first.cnicimages!.isEmpty==true?Center(child: Text("Please provide cnic to display" ),): Image.network(
                      fit: BoxFit.contain,
                        "${Api.BASE_URL}/images/${AuthenticateController.userdata.first.cnicimages![0]}"
                    ):AuthenticateController.userdata.first.profileimages!.isEmpty==true?
                    const Center(child: Text("Please provide profile to display" )):
                        
                       Image.network(
                      fit: BoxFit.contain,
                        "${Api.BASE_URL}/images/${AuthenticateController.userdata.first.profileimages![0]}"
                    ),
                    
                    

                  ),
                  ),
              ),),
          ),
          Positioned.fromRect(
              rect: Rect.fromCenter(center: Offset(190, 80), width: 190, height:130),
            child: Card(
              semanticContainer: true,
              child: SizedBox(
                width: 190,
                height: 120,
                child: Column(
                  // fit: StackFit.loose,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text("Profile Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey )),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon:  Icon(
                          Icons.upload_file,
                          color: Colors.black38,
                        ),
                        label: Obx(
                          () => Text(
                            isCnic==true?"Select Images ${imgcontroller.uploadCnicList.length}":
                            "Select Images ${imgcontroller.uploadProfileList.length}",
                            style: const TextStyle(
                              fontSize: 18,
                              // wordSpacing: 2,
                              color: Colors.black38,
                              leadingDistribution:
                                  TextLeadingDistribution.proportional,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: TextButton(
                        onPressed: () async{
                           //pick images
                         
                          isCnic==true?
                         { 
                          await imgcontroller.pickImages(),//pick a image 
                          await imgcontroller.uploadCnic(),//upload image
                          await UserRepository().uploadCnicPicture (//upload picture string to user
                              images: imgcontroller.uploadCnicList),
                              AuthenticateController.userdata.first.cnicimages=imgcontroller.uploadCnicList
                              }
                              
                          :
                          {
                          await  imgcontroller.pickImages(),
                          await imgcontroller.uploadProfile(),
                          await UserRepository().uploadProfilePicture (
                              images: imgcontroller.uploadProfileList),
                              AuthenticateController.userdata.first.profileimages=imgcontroller.uploadProfileList
                              
                              };
                          //create user api to insert images in cnic and  profile
                          print(imgcontroller.uploadCnicList);
                          imgcontroller.imageList.clear();
                          // imgcontroller.uploadImageList.clear();
                        },
                        style: TextButton.styleFrom(
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            side: BorderSide(
                              color: Color.fromARGB(255, 158, 158, 158),
                            ),
                          ),
                        ),
                        child:  Text(
                          isCnic==true?
                          'Upload Cnic':'Upload Profile',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
           Positioned.fromRect(
            rect: Rect.fromCenter(center: const Offset(190, 25), width: 50, height:50),
            // alignment: Alignment.topCenter,
            child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey,
                child: Icon( isCnic==true?
                        Icons.recent_actors:
                  Icons.person,
                  size: 34,
                  color: Colors.black,
                )),
                   ),

        ],
      ),
    );
  }
}
