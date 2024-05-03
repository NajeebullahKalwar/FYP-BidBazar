const orderController = require('../controllers/order_controller');

const orderRoutes= require('express').Router();




orderRoutes.post("/create",orderController.createOrder);
orderRoutes.get("/fetch/:buyerId",orderController.fetchOrders);



module.exports=orderRoutes;