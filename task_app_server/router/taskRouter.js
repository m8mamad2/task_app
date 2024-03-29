const express = require('express');
const router  = express.Router();
const {addTaskController ,deleteTaskController ,updateTaskController ,getTaskController ,getAllTaskController, getTaskFromDateController, searchTaskController, chartTaskController } = require('./../controller/taskController');

//* Add A Task 
router.post('/addTask', addTaskController);

//* Update A Task 
router.put('/updateTask', updateTaskController);

//* Delete a Tack
router.delete('/deleteTask', deleteTaskController);

//* Get A Task
router.post('/getTask', getTaskController);

//* Get All Tasks
router.get('/getAllTask', getAllTaskController);

//* Get Task From Date
router.post('/getTaskFromDate', getTaskFromDateController);

//* Get Task From Date
router.post('/searchTask', searchTaskController);

//* Get Chart
router.get('/getChart', chartTaskController);


module.exports = router;

//2024-03-22