const productModel = require("../models/product_model");

const productController = {

    createProduct:async function(req,res){
        try{
            const productData = req.body;//data send    
            console.log(productData);
            // const jsonData = JSON.stringify(productData);
            

            const newProduct = new productModel(productData);             
            await newProduct.save();//data save to database

            return res.json({success:true,message:"Product successfully created",data:newProduct}); 
        }catch(e){
            return res.json({success:false,message:`Product creation an error occured  ${e}`});
        }
    },
    getAllProducts:async function(req,res){

        try{
            const getProducts = await productModel.find();//it uses mongoose local client which fetch all data from db   
                         
            return res.json({success:true,message:"Product Found",data:getProducts}); 
        }catch(e){
            return res.json({success:false,message:`Erorr Product Not Found   ${e}`});
        }
    },
  
    getAllProductsById:async function(req,res){// for category
        try{
            const id=   req.params.id;
            
            // const  products=await productModel.findById(id);
            const  products=await productModel.find({category:id});
            
            return res.json({success:true,message:"",data:products}); 
    
        }catch(e){
         return res.json({success:false,message:`Product not found!  ${e}`});
    
        }
    },

    
    getUserProduct:async function(req,res){ // for user
        try{
            const user=req.params.user;
                      
            const foundProduct =  await productModel.find(
                {user:user}
                );
                // console.log("product "+foundProduct);
            if(foundProduct==""){
                
                return res.json({success:false,data:[],message:"There is no item in your cart" });
            }else

                return res.json({success:true,message:"Products found",data:foundProduct });

        
        }catch(ex){
            return res.json({success:false,message:ex.message });

        }

    }
    


}


module.exports = productController;