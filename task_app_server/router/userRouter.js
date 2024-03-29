const express = require('express');
const router  = express.Router();
const { changeProfileController ,getUserController ,updateUserNameController, deleteAccountController } = require('./../controller/userController');


//* Get Current User
router.get('/getUser', getUserController);

//* Update Profile Avatar
router.put('/updateProfile', changeProfileController);

//* Update User Name
router.put('/updateUserName', updateUserNameController);

//* Delete Account
router.delete('/deleteAccount', deleteAccountController);


module.exports = router;
