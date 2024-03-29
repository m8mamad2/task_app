const moment = require('moment');
const taskModel = require('./../models/taskModel');


function dateAsNameFun(){
    const weekdays = [];
    for (let i = 0; i < 7; i++) {
      weekdays.push(moment().add(i, 'days').locale('en').format('dddd'));
    }
    return weekdays;
}

function dateAsNumberFun(){
const weekdays = [];
for (let i = 0; i < 7; i++) {
    weekdays.push(moment().add(i, 'days').format('YYYY-MM-DD'));
}
return weekdays;
}
 
 async function getWorkTimeFromDB (){
    const dateAsNumber = dateAsNumberFun();
    const dateAsLetter = dateAsNameFun();
    const dataList = [];

    for(let i = 0; i < dateAsNumber.length; i++){ 

        var ox = await taskModel.find( { date: dateAsNumber[i] }, ).select('diff_time');
        const oneLetterDay = dateAsLetter[i];

        let totalHour = 0;
        let totalMinute = 0;
        let totalSecond = 0;
        
        for(let j = 0; j < ox.length; j ++){//? one Task in That Day 
            var oneTaskInDay = ox[j]['diff_time'];
            if(oneTaskInDay !== null && isNaN(oneTaskInDay)){
                var hour = Number(oneTaskInDay.split('.')[0].split(':')[0]);
                var minute = Number(oneTaskInDay.split('.')[0].split(':')[1]);
                var second = Number(oneTaskInDay.split('.')[0].split(':')[2]);
                totalHour += hour;
                totalMinute += minute;
                totalSecond += second;
            }
        }
        totalMinute += Math.floor(totalSecond / 60);
        totalHour += Math.floor(totalMinute / 60);
        totalMinute = totalMinute % 60;
        totalSecond = totalSecond % 60;
        dataList.push(
            { [oneLetterDay] : `${totalHour}:${totalMinute}:${totalSecond}` } );

    }
    console.log(`Dtaa ---->`, dataList);
    return dataList;
}


module.exports =  getWorkTimeFromDB;
