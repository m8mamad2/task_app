const express = require('express');
const router  = express.Router();

const {signupController , loginController , otpController } = require('./../controller/authControler');

//* SIGNUP 
router.post('/signup', signupController);

//* LOGIN 
router.post('/login', loginController);

//* OTP 
router.post('/otp', otpController);


module.exports = router;
