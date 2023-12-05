const bidModel = require("../models/bid_model");



const bidController={

    createbid:async function(req,res) {
        try{
            const {user,items} = req.body;

            const newBid=bidModel({
                user:user,
                items:items
            });
             
            await newBid.save();

            return res.json({success:true,message:"bid added! ",data:newBid });
      
        }catch(ex){
            return res.json({success:false,message:`bid can not added :  ${ex}` });

        }

    },

    fetchbid:async function(req,res) {
            try{
                const userId = req.params.userId;
                
                const foundbids = await bidModel.find({
                    "user.id":userId
                });

                return res.json({success:true,message:"bid found",data:foundbids});

                
            }catch(ex){
                return res.json({success:false,message:`"bid not found ${ex}"`});

            }
    },

    updateBidStatus:async function(req,res) {
        try{
            
            const {bidId,status}=req.body;  
            const updateBid = await bidModel.findOneAndUpdate(
                {_id:bidId},//find
                {status:status},//update
                {new: true}
            );
            
            if(updateBid==null){
            return res.json({success:false,message:"bid not found."});

            }
            return res.json({success:true,message:"bid found and updated status.",data:updateBid});

            
        }catch(ex){
            return res.json({success:false,message:`"bid not found ${ex}"`});

        }
}


};


module.exports=bidController;



