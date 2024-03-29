
const error = (res,statusCode, msg,)=>{
    res.status(statusCode).send({msg:msg});
}

module.exports = error