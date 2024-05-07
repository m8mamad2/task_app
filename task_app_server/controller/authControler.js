const error = require('./../utils/response_handler/error_handler')
const authModel = require('./../models/authModel');
const successSignup = require('./../utils/response_handler/success_handler');
const asyncHandler = require('express-async-handler');

const signupController = asyncHandler(async(req,res)=>{
    
    const { name, email, password } = req.body;
    if( !name || !email || !password) return error(res, 401, 'All Field Sholud Be Complete !');
    
    const isExist = await authModel.findOne({ email });
    if(isExist)return error(res, 401, 'Email is Already Taken !');
    
    const user = await authModel.create({ name: name, email: email, password: password,profile_image: 1, token:''});
    const token = user.createJWT();
    
    try{
        await authModel.updateOne({ _id:user._id },{ token:token });
    }
    catch(e){
        console.log(`${e}`.bgCyan);
    }
    
    return successSignup(res, 200, 'Login Success :)', token, name, email, 1);

})

const loginController = asyncHandler(async(req,res,)=>{

    const { email, password } = req.body;

    if( !email || !password)return error(res,401,'Not Ok');
    
    
    const user = await authModel.findOne({ email }).select('+password');

    if(user === null || !user)  return res.status(400).send('no Found');
    
    const isMatch = await user.comparePassword(password);
    if(!isMatch) return error(res, 401, 'Password or Email is Wrong !');
    
    user.password = undefined
    const token = user.createJWT();
    return successSignup(res, 200, 'Login Success :)', token, user.name ,email, 1);

})

const otpController = ()=>{}

module.exports = { signupController ,loginController ,otpController }

