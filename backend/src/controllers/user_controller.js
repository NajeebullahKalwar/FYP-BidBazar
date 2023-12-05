
//multiple function create update delete export

const UserModel = require("../models/user_model");

const userController={

createAccount:async function(req,res){

    try{
        const userData = req.body;//data send    
        const newUser = new UserModel(userData);
         
        await newUser.save();//data save to database
        return res.json({success:true,message:"account successfully created",data:newUser}); 
    }catch(e){
        return res.json({success:false,message:`account creation an error occured  ${e}`});
    }

},

SignIn:async function(req,res){
        try{
            const {email,password,usertype}=req.body;

            const foundUser = await UserModel.findOne({email:email});

            if(!foundUser){
            return res.json({success:false,message:`User not found! `});
            }

            passwordMatches= foundUser.password==password?true:false;
            
            if(!passwordMatches){
                return res.json({success:false,message:`Password not matches ! `});
                }
            
                userType=foundUser.usertype;

                return res.json({success:true,message:`Successfully login! `,data:foundUser});

        }catch{
            return res.json({success:false,message:`An error occured to Login  ${e}`});
        }
}


};



module.exports =userController;