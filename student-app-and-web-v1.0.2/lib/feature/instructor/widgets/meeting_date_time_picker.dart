import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateMeetingScreen extends StatefulWidget {
  final String instructorId;

  const CreateMeetingScreen({super.key, required this.instructorId});

  @override
  PickerDateTimeRouteState createState() => PickerDateTimeRouteState();
}


class PickerDateTimeRouteState extends State<CreateMeetingScreen> {

  late Future<DateTime?> selectedDate;
  String date = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[

          const Spacer(flex: 10),

          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 45,
            color: Colors.grey[300],
            child:
            Text("$date : $time"),
          ),


          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 30)
              ),
              child: const Text("PICK DATE & TIME", style: TextStyle(color: Colors.white)),
              onPressed: (){
                showDialogPicker(context);
              },
            ),
          ),


        ],
      ),
    );
  }



  void showDialogPicker(BuildContext context){
    selectedDate = showDatePicker(
      context: context,
      helpText: 'Your Date of Birth',
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:  ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if(value == null) return;
        date = value.toString();
      });
      showDialogTimePicker(context);
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void showDialogTimePicker(BuildContext context){
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedTime.then((value) {
      setState(() {
        if(value == null) return;
        time = "${value.hour} : ${value.minute}";
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

}