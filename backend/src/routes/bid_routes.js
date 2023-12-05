const bidController = require("../controllers/bid_controller");




const bidRoutes= require('express').Router();


bidRoutes.post("/",bidController.createbid);
bidRoutes.get("/:userId",bidController.fetchbid);
bidRoutes.put("/updateStatus",bidController.updateBidStatus);





module.exports=bidRoutes;