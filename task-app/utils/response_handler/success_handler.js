const authSuccessHandler = (res, statusCode, msg,token,name, email,profile_image)=>{
    res.status(statusCode).send(
        {
            success: true,
            message: msg,
            user:{
                name: name,
                email: email,
                profile_image: profile_image,
                token: token
            },
        }
    )
}

module.exports = authSuccessHandler;