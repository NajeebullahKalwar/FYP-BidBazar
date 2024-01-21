const mongoose  = require("mongoose");


const cartItemSchema = new mongoose.Schema({
    product:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Product',
    },
    quantity:{
        type:Number,
        default:1
    },
});


const cartSchema =  mongoose.Schema({//nested object
    user:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        required:true
    },
    items:{
    type:[cartItemSchema],
    default:[],
    },
}); 


cartSchema.pre("save",function(next){//save ke time kiya hoga
    next();
});


cartSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
delete update._id;
next();
});



const cartModel=mongoose.model("Cart",cartSchema);

module.exports=cartModel;