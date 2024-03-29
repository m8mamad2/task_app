const mongoose = require('mongoose');

const model = new mongoose.Schema({
    user:{
        type: mongoose.Types.ObjectId,
        ref:'auth_model',
    },
    title:String,
    des: String,
    priority: Number,
    date: String, 
    compelete: Boolean,
    start_time:String,
    end_time:String,
    is_running: Boolean,
    diff_time: String, //* Diff of Statr & End
},{ timestamps:true });

module.exports = mongoose.model('task_model', model);



