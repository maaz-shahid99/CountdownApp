import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'variables.dart';
class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
  }

  late Timer timer;

  void _startTimer() {
    if(flag==0)
      {
        totalTime =
            (timeInHours * 60 * 60) + (timeInMinutes * 60) + (timeInSeconds);
        chkTime = totalTime;
        percentTime = totalTime.toDouble();
      }

    else
      {
        totalTime = chkTime;
        percentTime = percentTime.toDouble();
      }

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (totalTime == 0) {
        setState(() {
          timer.cancel();
          changeSeconds = 0;
          controller.reverse();
          percent=0.0;
          chk = 1;
          flag=0;
        });
      }
      if (totalTime >= 1) {
        int timeCopy = totalTime;
        setState(() {

          if ((timeCopy / 3600) != 0) {
            changeHours = timeCopy ~/ 3600;
            timeCopy = timeCopy % 3600;
          }
          if ((timeCopy / 60) != 0) {
            changeMinutes = timeCopy ~/ 60;
            timeCopy = timeCopy % 60;
          }
          if (timeCopy != 0) {
            changeSeconds = timeCopy;
          }

          percent = (1/percentTime)*(totalTime);
          print(totalTime);
          totalTime--;
          chkTime--;

          if (timeCopy == 0) changeSeconds = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFF2E404E),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(
                  'Count Down Timer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Gemunu',
                  ),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 250.0,
                  lineWidth: 15.0,
                  progressColor: Colors.blueGrey,
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${changeHours < 10
                            ? changeHours.toString().padLeft(2, '0')
                            : changeHours.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        ' : ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '${changeMinutes < 10
                            ? changeMinutes.toString().padLeft(2, '0')
                            : changeMinutes.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        ' : ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '${changeSeconds < 10
                            ? changeSeconds.toString().padLeft(2, '0')
                            : changeSeconds.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: NumberPicker(
                                value: timeInHours,
                                minValue: 0,
                                maxValue: 23,
                                itemCount: 4,
                                zeroPad: true,
                                infiniteLoop: true,
                                onChanged: (value) => setState(() {
                                  timeInHours = value;
                                  changeHours = timeInHours;
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: NumberPicker(
                                value: timeInMinutes,
                                minValue: 0,
                                maxValue: 59,
                                itemCount: 4,
                                zeroPad: true,
                                infiniteLoop: true,
                                onChanged: (value) => setState(() {
                                  timeInMinutes = value;
                                  changeMinutes = timeInMinutes;
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 2,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: NumberPicker(
                                value: timeInSeconds,
                                minValue: 0,
                                maxValue: 59,
                                itemCount: 4,
                                zeroPad: true,
                                infiniteLoop: true,
                                onChanged: (value) => setState(() {
                                  timeInSeconds = value;
                                  changeSeconds = timeInSeconds;
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 21.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: CircleBorder(),
                                  primary: Color(0xFF2E404E),
                                ),
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  progress: controller,
                                  size: 35,
                                ),
                                onPressed: () {
                                  chk++;
                                  setState(() {
                                    if (chk % 2 == 0) {
                                      controller.forward();
                                      _startTimer();
                                    } else {
                                      controller.reverse();
                                      timer.cancel();
                                      flag=1;
                                    }
                                    print(chk);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              height: 50,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  fixedSize: Size(70, 70),
                                  shape: CircleBorder(),
                                  primary: Color(0xFF2E404E),
                                ),
                                child: Icon(
                                  Icons.stop_rounded,
                                  size: 35.0,
                                ),
                                onPressed: () {
                                  setState(() {
                                    controller.reverse();
                                    timer.cancel();
                                    percent = 0.0;
                                    timeInHours = 0;
                                    changeHours = 0;
                                    timeInMinutes = 0;
                                    changeMinutes = 0;
                                    timeInSeconds = 0;
                                    changeSeconds = 0;
                                    chk = 1;
                                    totalTime = 0;
                                    flag=0;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
