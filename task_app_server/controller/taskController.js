const asyncHandler = require('express-async-handler');
const getIdFromToken = require('./../utils/getIdFromToken');
const taskModel = require('../models/taskModel');
const error = require('../utils/response_handler/error_handler');
const success = require('../utils/response_handler/success_task');
const getWorkTimeFromDB  = require('./../utils/chartService')

const addTaskController = asyncHandler(async(req,res)=>{
    
    const { title, des, priority, date, compelete, start_time, end_time, is_running,diff_time } = req.body;

    const user = getIdFromToken(req,res);
    if(!user)return error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');

    try{
        var re1s = await taskModel.create({  
            user: user,
            title: title,
            des: des,
            priority: priority,
            date:date,
            compelete:compelete,
            start_time: start_time,
            end_time: end_time,
            is_running: is_running,
            diff_time: diff_time
        });

        console.log(re1s);
        return success(res, 200, 'Task Successsfully Created ');
    }
    catch(e){ return error(res, 400, `Faild To Create Task ${e}`); }

});

const deleteTaskController = asyncHandler(async(req,res)=>{
    const { id } = req.body;

    const user = getIdFromToken(req,res);
    if(!user)error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');

    try{
        await taskModel.deleteOne({ _id: id , user:user }); 
        success(res, 200, 'delete was Successfully ');
    }
    catch(e){
        error(res, 400, `Delete was not Successfully ${e}`)
    }
});

const updateTaskController = asyncHandler(async(req,res)=>{
    const { id,  compelete, start_time, end_time, is_running, diff_time } = req.body;

    const user =  getIdFromToken(req,res);
    if(!user)return error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');
    
    try{
        var ress =  await taskModel.findOneAndUpdate(
            { _id: id, user: user},  
            { 
                compelete: compelete,
                start_time: start_time,
                end_time: end_time,
                is_running: is_running,
                diff_time: diff_time,
            },
            { new: true });
        
        if(ress === null)return error(res,400, 'Fail to Update Task');
        
        return success(res, 200, 'update was Success')
    }
    catch(e){   
        return error(res, 400, 'update was NOt Success')
    }


});

const getTaskController = asyncHandler(async(req,res)=>{
    const { id } = req.body;

    const user =  getIdFromToken(req,res);
    if(!user)error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');
    
    try{
        const data = await taskModel.findOne({ user:user, _id: id});
        if(!data)error(res,404, 'not Fonund');
        
        return res.status(200).json({ data });
    }
    catch(e){   
        error(res,404, 'not Fonund');
    }
});

const getAllTaskController = asyncHandler(async(req,res)=>{
    
    const user =  getIdFromToken(req,res);
    if(!user)error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');

    try{
        const data= await taskModel.find().where({ user: user});
        if(!data)error(res, 404, 'Not Found !');
        
        return res.status(200).json({ data: data})
    }
    catch(e){   
        error(res, 404, 'Not Found !');
    }
});

const getTaskFromDateController = asyncHandler(async(req,res)=>{

    const { date } = req.body;
    if(!date)return error(res, 401, 'Date is Require');

    const user =  getIdFromToken(req,res);
    if(!user)return error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');

    try{
        const data= await taskModel.find({ user: user, date: date});
        if(!data)return error(res, 404, 'Not Found !');
        
        return res.status(200).json({ data: data})
    }
    catch(e){   
        console.log(e);
        return error(res, 404, 'Not Found !');
    }
})

const searchTaskController = asyncHandler(async(req,res)=>{
    const { search } = req.body;
    if(!search)return error(res, 401, 'Date is Require');

    const user =  getIdFromToken(req,res);
    if(!user)return error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');


    try{
        const data= await taskModel.find({ user: user, title: search });
        if(!data)return error(res, 404, 'Not Found !');
        
        return res.status(200).json({ data: data})
    }
    catch(e){   
        console.log(e);
        return error(res, 404, 'Not Found !');
    }

})

const chartTaskController = asyncHandler(async(req,res)=>{

    const user =  getIdFromToken(req,res);
    if(!user)return error(res, 401, 'OOOOOOOOOOOOOOOOOOOOOOo');

    try{
        const data= await getWorkTimeFromDB();
        console.log(data);
        return res.status(200).send(data);
    }
    catch(e){   
        console.log(e);
        return error(res, 404, 'Not Found !');
    }

})



module.exports = {addTaskController ,deleteTaskController ,updateTaskController ,getTaskController ,getAllTaskController, getTaskFromDateController, searchTaskController, chartTaskController }




