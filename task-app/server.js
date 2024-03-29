const express = require('express');
const app = express();
const dotenv = require('dotenv').config();
const morgan = require('morgan');
const cors = require('cors');
const colors = require('colors');

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


app.listen(8001, ()=> console.log(`Server is Starting ------`.bgWhite.black) )

