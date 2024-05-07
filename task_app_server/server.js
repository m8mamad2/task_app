const express = require('express');
const app = express();
const dotenv = require('dotenv').config();
const morgan = require('morgan');
const cors = require('cors');
const colors = require('colors');
const moment = require('moment');

//* DB 
const connectDB = require('./config/db');

//* Middleweare
const userAuth = require('./middleweaer/authMiddleweare');

//* Routers
const taskRouter =require('./router/taskRouter')
const authRouter = require('./router/authRouter')
const userRouter = require('./router/userRouter')

//*
connectDB();

//* MiddleWeare
app.use(express.json());
app.use(morgan('dev'));
app.use(cors());



//* Router
app.use('/api/auth', authRouter);
app.use('/api/task', userAuth, taskRouter);
app.use('/api/user', userAuth, userRouter);
app.get('/', (req,res)=>{
    
    let xs = moment();
    let toDay = moment().format('YYYY-MM-DD');
    let sevenDayBefore = moment().subtract(7, 'days').format('YYYY-MM-DD');

    for(var i = 0; i <= 7; i++ ){
      var d = moment().subtract(i, 'days').format('YYYY-MM-DD');
      console.log(d);
    }

    res.json({a: toDay, b: sevenDayBefore});

} )



app.listen(8001, ()=> console.log(`Server is Starting ------`.bgWhite.black) )


