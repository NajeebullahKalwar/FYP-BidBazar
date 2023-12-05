const mongoose  = require("mongoose");


const bidProductSchema = new mongoose.Schema({//same as order but different logic
    product:{
        type:Map, //not ref as static product 
        required:true,
    },
    quantity:{
        type:Number,
        default:1
    },
});


const bidSchema =  mongoose.Schema({//nested object
    user:{
        type:Map,
        required:true
    },
    
    items:{
    type:[bidProductSchema],
    default:[],
    },
    status:{
        type:String,
        default:"bid succefully placed" ,
    }

}); 


bidSchema.pre("save",function(next){//save ke time kiya hoga
    next();
});


bidSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
delete update._id;//the _id is  immutable we hhave delete it also mongoose implicitly do that
next();
});



const bidModel=mongoose.model("Bid",bidSchema);

module.exports=bidModel;
