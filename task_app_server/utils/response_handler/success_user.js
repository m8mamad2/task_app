const userSuccessHandler = (res, statusCode, msg,user)=>{
    res.status(statusCode).send(
        {
            success: true,
            message: msg,
            user:user
        }
    )
}


module.exports = userSuccessHandler;