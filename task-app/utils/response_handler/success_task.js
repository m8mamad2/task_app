const taskSuccessHandler = (res, statusCode, msg)=>{
    res.status(statusCode).json(
        {
            success: true,
            message: msg,
        }
    )
}

module.exports = taskSuccessHandler;