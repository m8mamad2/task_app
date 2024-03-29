const JWT = require('jsonwebtoken');
const error = require('./response_handler/error_handler');

const getIdFromToken = (req,res)=>{

    const authHeader = req.headers.Authorization || req.headers.authorization;
    if(!authHeader || !authHeader.startsWith('Bearer'))error(res, 401, "Auth Failed");
    const token = authHeader.split(" ")[1];

    try{
        const payload = JWT.verify(token, process.env.JWT_SECRET_KEY);
        return payload.userId;
    }
    catch(e){ 
        return false;
    }
}


module.exports = getIdFromToken;