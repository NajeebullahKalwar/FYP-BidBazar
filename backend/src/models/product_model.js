const mongoose = require('mongoose');
const uuid = require('uuid');





const productSchema=mongoose.Schema({
    user:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        required:true
    },
    name:{
        type:String,
        required:true
    },
    // model:{
    //     type:String,
    //     default: "not Entered"
    // },
    specs:{
        type:String,
        default: "not Entered"
    },
    price:{
        type:Number,
        required:true,
    },
    wishlist:{
        type:Boolean,
        default:false,        
    },
    images:{
        type:Array,
        default:[]
    },
    category:{
        type:mongoose.Schema.ObjectId,
        ref:"Category", //model name as reference pass
        required:true,
    }

});


    // add pre-hook to mongoose schema methods to perform operation like save update

productSchema.pre("save",function(next){//save ke time kiya hoga  
    next();
});


productSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
    const update= this.getUpdate();
    delete update._id;
    next();
}
);



const productModel=mongoose.model('Product',productSchema);

module.exports=productModel;