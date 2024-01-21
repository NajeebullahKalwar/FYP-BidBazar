const express= require('express');
const bodyParser=require('body-parser');
const helmet=require('helmet');
const morgan=require('morgan');
const cors=require('cors');
//for image uploading

const mongoose = require('mongoose');
//all routes
const userRouter=require('./routes/user_routes');
const catRouter = require('./routes/cat_routes');
const productRoute = require('./routes/product_routes');
const cartRoutes = require('./routes/cart_routes');
const bidRoutes = require('./routes/bid_routes');
const image = require('./controllers/image_controller');
const imageRoute = require('./routes/image_route');
const wishListRoutes = require('./routes/wishList_route');




//Set up default mongoose connection
// var mongoDB = 'mongodb://127.0.0.1/my_database';
// mongoose.connect(mongoDB, { useNewUrlParser: true });
//  //Get the default connection
// var db = mongoose.connection;
// //Bind connection to error event (to get notification of connection errors)
// db.on('error', console.error.bind(console, 'MongoDB connection error:'));
// db.on('error', console.error.bind(console, 'MongoDB connection error:'));

const app=express();//all request are handle by app
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
// app.use(bodyParser.)
app.use(bodyParser.urlencoded({extended:false}));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());

const port=4000;
const hostname='192.168.1.149';



mongoose.connect("mongodb://localhost:27017/bidbazar");

app.get("/",(req,res)=>{
// console.log("najeebullah");

// const response={message:'AIPs is working '}
res.json({success:true,message:"Hello World"},);
// res.send(response);
});

app.use("/api/user",userRouter);//user routes
app.use("/api/category",catRouter);
app.use("/api/product",productRoute);
app.use("/api/cart",cartRoutes);
app.use("/api/bid",bidRoutes);
app.use("/api/images", express.static('upload/images'), imageRoute );
app.use("/api/wishList",wishListRoutes);


app.listen(port,hostname,()=>{

    // console.log("server is up http://localhost:4000");
    console.log(`server is up http://${hostname}:4000`);

});

