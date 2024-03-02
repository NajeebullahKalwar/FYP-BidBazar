const path = require("path");
const multer = require("multer");
const image = require("../controllers/image_controller");

const imageRoute= require('express').Router();



const storage = multer.diskStorage({
    destination:'./upload/images',
    filename:(req,file,cb)=>{

        // file.forEach((file, index) => {

            // Customize the filename for each file
            const uniqueFileName = `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`;
            // Pass the unique filename to the callback
            cb(null, uniqueFileName);
        //   });s
    }
});

const upload=multer({
    storage:storage,
    // dest:'./upload/images',
});



imageRoute.post("/upload", upload.array('images'),image.imageUpload );

imageRoute.delete('/delete',image.deleteImage );



module.exports=imageRoute;
