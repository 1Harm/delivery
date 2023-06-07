import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StepperDemo extends StatefulWidget {
  StepperDemo() : super();

  @override
  StepperDemoState createState() => StepperDemoState();
}

class StepperDemoState extends State<StepperDemo> {
  int current_step = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: Text(AppLocalizations.of(context)!.acc),
        content: Text(''),
        isActive: true,
      ),
      Step(
        title: Text(AppLocalizations.of(context)!.pre),
        content: Text(''),
        isActive: true,
      ),
      Step(
        title: Text(AppLocalizations.of(context)!.del),
        content: Text(''),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C33),
      ),
      body: Container(
        child: Stepper(
          currentStep: current_step,
          steps: steps,
          type: StepperType.vertical,
          onStepTapped: (step) {
            setState(() {
              current_step = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (current_step < steps.length - 1) {
                current_step = current_step + 1;
              } else {
                current_step = 0;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (current_step > 0) {
                current_step = current_step - 1;
              } else {
                current_step = 0;
              }
            });
          },
        ),
      ),
    );
  }
}
