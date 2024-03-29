const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const validator = require('validator');
const JWT = require('jsonwebtoken');

const model = new mongoose.Schema({
    name: String,
    email: String,
    password:{
        type:String,
        select: true
    },
    profile_image:Number,
    token: String
 },
 { timestamps: true }
);


//? hashing Password
model.pre('save', async function(){
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt)
})

//? compare Password
model.methods.comparePassword = async function(userPass){
    const isMatch = await bcrypt.compare(userPass, this.password);
    return isMatch;
}

//? JWT
model.methods.createJWT = function(){
    return JWT.sign({ userId: this._id }, process.env.JWT_SECRET_KEY);
}

module.exports = mongoose.model('auth_model', model);


