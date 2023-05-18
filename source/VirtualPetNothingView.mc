import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Weather;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Time.Gregorian;

class VirtualPetNothingView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }


    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

 
    function onShow() as Void {
    }

    
    function onUpdate(dc as Dc) as Void {
        var mySettings = System.getDeviceSettings();
       var myStats = System.getSystemStats();
       var info = ActivityMonitor.getInfo();
       var timeFormat = "$1$:$2$";
       var clockTime = System.getClockTime();
       var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
              var hours = clockTime.hour;
               if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {   
                timeFormat = "$1$:$2$";
                hours = hours.format("%02d");  
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        var weekdayArray = ["Day", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"] as Array<String>;
        var monthArray = ["Month", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] as Array<String>;
 
 var userBattery = "-";
   if (myStats.battery != null){userBattery = Lang.format("$1$",[((myStats.battery.toNumber())).format("%2d")]);}else{userBattery="-";} 

   var userSTEPS = 0;
   if (info.steps != null){userSTEPS = info.steps.toNumber();}else{userSTEPS=0;} 

  var userNotify = "-";
   if (mySettings.notificationCount != null){userNotify = Lang.format("$1$",[((mySettings.notificationCount.toNumber())).format("%2d")]);}else{userNotify="-";} 

var userAlarm = "-";
   if (mySettings.alarmCount != null){userAlarm = Lang.format("$1$",[((mySettings.alarmCount.toNumber())).format("%2d")]);}else{userAlarm="-";} 

     var userCAL = 0;
   if (info.calories != null){userCAL = info.calories.toNumber();}else{userCAL=0;}  
   
   var getCC = Toybox.Weather.getCurrentConditions();
    var TEMP = "--";
    var FC = "-";
     if(getCC != null && getCC.temperature!=null){     
        if (System.getDeviceSettings().temperatureUnits == 0){  
    FC = "C";
    TEMP = getCC.temperature.format("%d");
    }else{
    TEMP = (((getCC.temperature*9)/5)+32).format("%d"); 
    FC = "F";   
    }}
     else {TEMP = "--";}
    
    var cond;
    if (getCC != null){ cond = getCC.condition.toNumber();}
    else{cond = 0;}//sun
    
   //Get and show Heart Rate Amount

var userHEART = "--";
if (getHeartRate() == null){userHEART = "--";}
else if(getHeartRate() == 255){userHEART = "--";}
else{userHEART = getHeartRate().toString();}

       var centerX = (dc.getWidth()) / 2;
       //var centerY = (dc.getHeight());


        var timeText = View.findDrawableById("TimeLabel") as Text;
        var dateText = View.findDrawableById("DateLabel") as Text;
        var batteryText = View.findDrawableById("batteryLabel") as Text;
        var heartText = View.findDrawableById("heartLabel") as Text;
        var stepText = View.findDrawableById("stepsLabel") as Text;
        var calorieText = View.findDrawableById("caloriesLabel") as Text;
        var temperatureText = View.findDrawableById("tempLabel") as Text;
        var temperatureText1 = View.findDrawableById("tempLabel1") as Text;
        var notificationLabel = View.findDrawableById("notificationLabel") as Text;
        var alarmLabel = View.findDrawableById("alarmLabel") as Text;
       var notificationcountLabel = View.findDrawableById("notificationcountLabel") as Text;
        var alarmcountLabel = View.findDrawableById("alarmcountLabel") as Text;
    
        if (System.getDeviceSettings().screenHeight > 299){
        var connectTextP = View.findDrawableById("connectLabelP") as Text;
        var connectTextB = View.findDrawableById("connectLabelB") as Text;
        connectTextP.locY = (((System.getDeviceSettings().screenHeight)*25.5/30));
        connectTextB.locY = (((System.getDeviceSettings().screenHeight)*25.5/30));
         if (mySettings.phoneConnected == true){connectTextP.setColor(0x48FF35);}
    else{connectTextP.setColor(0xEF1EB8);}
    if (myStats.charging == true){connectTextB.setColor(0x48FF35);}
    else{connectTextB.setColor(0xEF1EB8);}
        connectTextP.setText("  #  ");
        connectTextB.setText("  @  ");
        }else { }
       
       var HY = System.getDeviceSettings().screenHeight;
       var WX = System.getDeviceSettings().screenWidth;
        dateText.locY = (((HY)*21/30));
        timeText.locY = (((HY)/30));   

        if(mySettings.screenShape != 1){
          
        batteryText.locX = (((WX)/30));
        heartText.locX = (((WX)*28/30));
        stepText.locX = (((WX)*3/30));
        stepText.locY = (((HY)*7/30));
        calorieText.locX = (((WX)*27/30));
        calorieText.locY = (((HY)*7/30));
        temperatureText.locY = (((HY)*19/30));
        temperatureText1.locY = (((HY)*20/30));
        temperatureText.locX = (((WX)*3/30));
        temperatureText1.locX = (((WX)*27/30));
        notificationcountLabel.locY = (((HY)*25/30));
        alarmcountLabel.locY = (((HY)*25/30));
        notificationLabel.locY = (((HY)*25/30));
        alarmLabel.locY = (((HY)*25/30));
        notificationLabel.locX = (((WX)*10/30));
        alarmLabel.locX = (((WX)*20/30));
        }else{
        batteryText.locX = (((WX)/30));
        heartText.locX = (((WX)*28/30));
        stepText.locX = (((WX)*3/30));
        stepText.locY = (((HY)*10/30));
        calorieText.locX = (((WX)*27/30));
        calorieText.locY = (((HY)*10/30));
        temperatureText.locY = (((HY)*17/30));
        temperatureText1.locY = (((HY)*17/30));
        temperatureText.locX = (((WX)*3/30));
        temperatureText1.locX = (((WX)*27/30));

        if (HY>299){
        notificationcountLabel.locY = (((HY)*24/30));
        alarmcountLabel.locY = (((HY)*24/30));
        notificationLabel.locY = (((HY)*24/30));
        alarmLabel.locY = (((HY)*24/30));
        alarmLabel.locX = (((WX)*19/30));
        notificationLabel.locX = (((WX)*21/60));
        }else{
           alarmLabel.locY = (((HY)*23/30));
           alarmcountLabel.locY = (((HY)*23/30));
           notificationLabel.locY = (((HY)*23/30));
           notificationcountLabel.locY = (((HY)*23/30));
        }

        }
        

        timeText.setText(timeString);
        dateText.setText(weekdayArray[today.day_of_week]+" , "+ monthArray[today.month]+" "+ today.day +" " +today.year);
        batteryText.setText(" = "+userBattery+"%");
        heartText.setText(userHEART+" + ");
        stepText.setText(" ^ "+userSTEPS);
        calorieText.setText(userCAL+" ~ ");
        temperatureText.setText(weather(cond));
        temperatureText1.setText(TEMP+" "+FC+" ");
        notificationLabel.setText("r");
        alarmLabel.setText("r");  
        notificationcountLabel.setText(userAlarm+"                ");
        alarmcountLabel.setText("               "+userNotify); 
        var dog = dogPhase(today.sec, today.min);
       var object = object(today.day_of_week);//today.day_of_week
        View.onUpdate(dc);
        
       
        dog.draw(dc);
        //object.draw(dc); //for testing
       if (userSTEPS > 3000){ object.draw(dc);} 
        if (mySettings.screenShape == 1){
          if(System.getDeviceSettings().screenHeight < 301){dc.setPenWidth(22);}
          else{dc.setPenWidth(30);}

//0x555555 for 64 bit color and 16 bit color - only AMOLED can show 0x272727
dc.setColor(0x272727, Graphics.COLOR_TRANSPARENT);
dc.drawCircle(centerX, centerX, centerX);
dc.setColor(0x48FF35, Graphics.COLOR_TRANSPARENT);
dc.drawArc(centerX, centerX, centerX, Graphics.ARC_CLOCKWISE, 90, 47);
dc.setColor(0xFFFF35, Graphics.COLOR_TRANSPARENT);
dc.drawArc(centerX, centerX, centerX, Graphics.ARC_CLOCKWISE, 45, 2);
dc.setColor(0xEF1EB8, Graphics.COLOR_TRANSPARENT);
dc.drawArc(centerX, centerX, centerX, Graphics.ARC_CLOCKWISE, 0, 317);
dc.setColor(0x00F7EE, Graphics.COLOR_TRANSPARENT);
dc.drawArc(centerX, centerX, centerX, Graphics.ARC_CLOCKWISE, 315, 270);
dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
dc.drawArc(centerX, centerX, centerX, Graphics.ARC_CLOCKWISE, 268, 266 - (userSTEPS/56));
}else 
{
  dc.setPenWidth(15);
  dc.setColor(0x272727, Graphics.COLOR_TRANSPARENT);
  dc.drawRectangle(0, 0, dc.getWidth(), dc.getHeight());
  dc.setColor(0x48FF35, Graphics.COLOR_TRANSPARENT);
  dc.drawLine(0, 0, dc.getWidth(), 0);
  dc.setColor(0xFFFF35, Graphics.COLOR_TRANSPARENT);
  dc.drawLine(dc.getWidth(), dc.getHeight(), 0, dc.getHeight());
  dc.setColor(0xEF1EB8, Graphics.COLOR_TRANSPARENT);
  dc.drawLine(0, 0, 0, dc.getHeight());
  dc.setColor(0x00F7EE, Graphics.COLOR_TRANSPARENT);
  dc.drawLine(dc.getWidth(), 0, dc.getWidth(), dc.getHeight());
}

        
    }


    function onHide() as Void { }

    
    function onExitSleep() as Void {}

    
    function onEnterSleep() as Void {}

function weather(cond) {
  if (cond == 0 || cond == 40){return "b";}//sun
  else if (cond == 50 || cond == 49 ||cond == 47||cond == 45||cond == 44||cond == 42||cond == 31||cond == 27||cond == 26||cond == 25||cond == 24||cond == 21||cond == 18||cond == 15||cond == 14||cond == 13||cond == 11||cond == 3){return "a";}//rain
  else if (cond == 52||cond == 20||cond == 2||cond == 1){return "e";}//cloud
  else if (cond == 5 || cond == 8|| cond == 9|| cond == 29|| cond == 30|| cond == 33|| cond == 35|| cond == 37|| cond == 38|| cond == 39){return "g";}//wind
  else if (cond == 51 || cond == 48|| cond == 46|| cond == 43|| cond == 10|| cond == 4){return "i";}//snow
  else if (cond == 32 || cond == 37|| cond == 41|| cond == 42){return "f";}//whirlwind 
  else {return "c";}//suncloudrain 
}


private function getHeartRate() {
  // initialize it to null
  var heartRate = null;

  // Get the activity info if possible
  var info = Activity.getActivityInfo();
  if (info != null) {
    heartRate = info.currentHeartRate;
  } else {
    // Fallback to `getHeartRateHistory`
    var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(1, true).next();
    if (latestHeartRateSample != null) {
      heartRate = latestHeartRateSample.heartRate;
    }
  }

  // Could still be null if the device doesn't support it
  return heartRate;
}

function object(dayofweek){
  var mySettings = System.getDeviceSettings();
  //0: normal 200 px 1:small 100 px 2:Large 200px 3:square
var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
var size = 0;
      if (System.getDeviceSettings().screenHeight < 301){
        size =1;
        growX=1.1;
        growY=1.6;
      }else if (System.getDeviceSettings().screenHeight > 390){
        size=2;
        growX=0.85;
        growY=growX*growX;
      }else if (mySettings.screenShape != 1){
        size=0;
        growX=0.80;
        growY=1;
      }else{
        size=0;
        growX=0.8;
        growY=1;
      }
  var venus2X =  mySettings.screenWidth *0.25*growX ;
  var venus2Y =  mySettings.screenHeight *0.18*growY ;
var objectARRAY;
if (size ==1){
 objectARRAY=[
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sunsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
      (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.monsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.tuessmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wedsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.thurssmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
            (  new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.frismall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
           ( new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.satsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
     ];
}
else if (size ==2){
 objectARRAY=[
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sunbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
      (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.monbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.tuesbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wedbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.thursbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
            (  new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.fribig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
           ( new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.satbig,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
     ];
}else{
 objectARRAY=[
      (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sun,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.mon,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.tues,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wed,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
              (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.thurs,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
            (  new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.fri,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
           ( new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sat,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
     ];
}
  return objectARRAY[(dayofweek-1)];
}



function dogPhase(seconds, minutes){
  var mySettings = System.getDeviceSettings();
  var size= 0;//0: normal 200 px 1:small 100 px 2:Large 200px 3:square
var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
      if (System.getDeviceSettings().screenHeight < 301){
        size=1;
        growX=1.1;
        growY=1.6;
      }else if (System.getDeviceSettings().screenHeight > 390){
        size=2;
        growX=0.85;
        growY=growX*growX;
      }else if (mySettings.screenShape != 1){
        size=3;
        growX=0.80;
        growY=1;
      }else{
        size=0;
        growX=0.8;
        growY=1;
      }

  var venus2X =  mySettings.screenWidth *0.25*growX ;
  var venus2Y =  mySettings.screenHeight *0.18*growY ;
  var dogARRAY;
if (size == 1){
 dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog2,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog3,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog4,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog0,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];
}
else if (size == 2){     
   dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog2,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog3,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog4,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
 ];      
}
else {
   dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog2,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog3,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog4,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
          (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog0,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ]; 
}
return dogARRAY[seconds%2+minutes%5];
}
}