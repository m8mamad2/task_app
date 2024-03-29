const mongoose = require('mongoose');

const connectDB = async()=>{
    try{
        const connection = await mongoose.connect(process.env.MONGO_HOST);
        console.log(`Connect DB -> ${mongoose.connection.host}`.bgWhite.black);
    }
    catch(e){
        console.log(`Error Connect DB -> ${e}`.bgWhite.black);
    }
}


module.exports = connectDB