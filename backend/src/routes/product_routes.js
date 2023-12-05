const productController = require('../controllers/product_controller');

const productRoute= require('express').Router();





productRoute.post("/",productController.createProduct
);//default function shift to user_controller

productRoute.get("/",productController.getAllProducts
);//default function shift to user_controller

productRoute.get("/category/:id",productController.getAllProductsById
);//default function shift to user_controller


module.exports=productRoute;