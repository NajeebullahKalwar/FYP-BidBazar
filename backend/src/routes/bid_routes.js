const bidController = require("../controllers/bid_controller");




const bidRoutes= require('express').Router();


bidRoutes.post("/",bidController.createbid);
bidRoutes.get("/fetchAllBidsForSeller/:seller",bidController.fetchbidsForSeller);
bidRoutes.get("/fetchAllBidsForBuyer/:buyerId",bidController.fetchbidsForBuyer);

bidRoutes.put("/updateStatus",bidController.updateBidStatus);





module.exports=bidRoutes;