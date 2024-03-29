const JWT = require('jsonwebtoken');
const error = require('../utils/response_handler/error_handler');


const userAuth = (req,res,next)=>{
    
    const authHeader = req.headers.Authorization || req.headers.authorization;

    if(!authHeader || !authHeader.startsWith('Bearer'))error(res,400,"Auth Failed")

    const token = authHeader.split(" ")[1];

    try{
        const payload = JWT.verify(token, process.env.JWT_SECRET_KEY)
        req.user = { userId: payload.userId }
        next()
    }
    catch(e){ error(res,400,`Auth Failed -> ${e}`) }
}

module.exports = userAuth;