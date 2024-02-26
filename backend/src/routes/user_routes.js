const userRouter = require('express').Router();
const userController=require("./../controllers/user_controller");

userRouter.post("/createAccount",userController.createAccount
);//default function shift to user_controller

userRouter.post("/signIn",userController.SignIn
);//default function shift to user_controller


userRouter.post("/find",userController.userFindById
);//default function shift to user_controller


module.exports=userRouter;