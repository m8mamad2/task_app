const authModel = require('../models/authModel');
const error = require('./../utils/response_handler/error_handler')
const success = require('./../utils/response_handler/success_user')
const asyncHandler = require('express-async-handler');
const getIdFromToken = require('./../utils/getIdFromToken')


const changeProfileController = asyncHandler(async(req,res)=>{

    const { profileId } = req.body;
    if(!profileId)return error(res, 401, 'Profile Id Avatar is Require !');

    const user = getIdFromToken(req,res);
    if(!user) return error(res,404,'User Not Found! ');
    
    console.log(`${user}`.bgCyan);

    try{
        await authModel.updateOne( { _id: user }, { profile_image: profileId }, );
        return  success(res,200);
    }
    catch(e){
        console.log(`${e}`.bgRed);
        return error(res,400,`Error ${e}`);
    }    
    

})

const getUserController = asyncHandler(async(req,res,)=>{

    const user = getIdFromToken(req,res);
    if(!user) return error(res,404,'User Not Found! ');

    try{
        const foundUser = await authModel.findOne({_id: user });
        if(foundUser === null || !foundUser)return error(res,404,'User Not Found! ');


        console.log(`${foundUser}`.bgCyan);
        return res.status(200).send(foundUser);
    }
    catch(e){ return error(res,404, `Erro ${e}`);}

})

const updateUserNameController = asyncHandler(async(req,res,)=>{
    const { name } = req.body;
    if(!name)return error(res, 401, 'Name is Require !');

    const user = getIdFromToken(req,res);
    if(!user) return error(res,404,'User Not Found! ');
    
    try{
        await authModel.updateOne( { _id: user }, { name: name }, );
        return  success(res,200);
    }
    catch(e){
        return error(res,400,`Error ${e}`);
    }   
})

const deleteAccountController = asyncHandler(async(req,res,)=>{

    const user = getIdFromToken(req,res);
    if(!user) return error(res,404,'User Not Found! ');
    
    try{
        await authModel.deleteOne({ _id: user });
        return  success(res,200);
    }
    catch(e){
        return error(res,400,`Error ${e}`);
    }   
})


module.exports = { changeProfileController ,getUserController ,updateUserNameController, deleteAccountController }

// { "_id" : ObjectId("65f9b9cd833ca4794e8ddc82"), "name" : "m8mamad2", "email" : "m8mamad2@gmail.com", "password" : "$2a$10$mGxizQv6tHwqqj5ootdefO/q25pUT8CP4FhrirFB2k6gesd8UCEna", "profile_image" : 1, "createdAt" : ISODate("2024-03-19T16:14:05.963Z"), "updatedAt" : ISODate("2024-03-19T16:14:05.963Z"), "__v" : 0 }
// 65f9b9cd833ca4794e8ddc82