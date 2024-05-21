const bidController = require("../controllers/bid_controller");




const bidRoutes= require('express').Router();


bidRoutes.post("/",bidController.createbid);
bidRoutes.get("/fetchAllBidsForSeller/:seller",bidController.fetchbidsForSeller);
bidRoutes.get("/fetchAllBidsForBuyer/:buyerId",bidController.fetchbidsForBuyer);

bidRoutes.post("/updateStatus",bidController.updateBidStatus);

bidRoutes.delete("/delete/:bidId/:buyerId",bidController.deletebid);




module.exports=bidRoutes;