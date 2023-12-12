

const image = {

    imageUpload:async function(req,res){

            try{
                // console.log(req.data);
                // console.log(req.element);

                
                // console.log(req.files);

                const imageUrls = req.files.map(element => `http://192.168.137.1:4000/api/images/${element.filename}`);

                console.log("new data");

                console.log(imageUrls);



    //  return res.json({success:true,message:`Image uploaded!` , data:req.files});
             return res.json({success:true,message:`Image uploaded!` , data:imageUrls});


            }catch(ex){
     return res.json({success:false,message:`Image not found!  ${ex}`});


            }
    }


}



module.exports = image;
