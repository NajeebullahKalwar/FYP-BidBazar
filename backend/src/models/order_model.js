const mongoose  = require("mongoose");
const { type } = require("os");


const item = mongoose.Schema({
    productid:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Product',
        
    },
    quantity:{
        type:Number,
        default:1
    }
});


const itemSchema = new mongoose.Schema({//same as order but different logic
    orderedProduct:{
      type:[item],
      default:[]
    },
    totalquantity:{
        type:Number,
        default:1
    }, 
    totalprice:{
        type:Number,
        default:0.0 ,
    },
    createdat: {
        type: Date,
        default: Date.now // Set default value to current date and time
    },
    status:{
        type:String,
        default:"order succefully placed" ,
    },
    // Productprice:{
    //     type:Number,
    //     default:0 ,
    // }
});

const orderSchema =  mongoose.Schema({//nested object
    buyer:{
        type:mongoose.Schema.ObjectId,
        ref:"User",
        required:true
    },
    // seller:{
    //     type:mongoose.Schema.ObjectId,
    //     ref:"User",
    //     required:true
    // },
    items:{
    type:[itemSchema],
    default:[],
    },
}); 


orderSchema.pre("save",function(next){//save ke time kiya hoga
    next();
});


orderSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
delete update._id;//the _id is  immutable we hhave delete it also mongoose implicitly do that
next();
});



const orderModel=mongoose.model("Order",orderSchema);

module.exports=orderModel;
