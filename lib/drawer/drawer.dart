import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tb_jam/screens/deletedTask/deleted_task.dart';
import 'package:tb_jam/screens/labels/labels_screen.dart';
import 'package:tb_jam/screens/notes/notes_screen.dart';
import 'package:tb_jam/screens/pomodoro/pomodoro_screen.dart';
import 'package:tb_jam/screens/schedule/schedule_screen.dart';
import 'package:tb_jam/screens/timetable/timable_screen.dart';

class Views {
  final IconData icon;
  final String title;
  final Widget screen;

  Views(this.icon, this.title, this.screen);
}

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

int _currentSelected = 0;

class _DrawerMenuState extends State<DrawerMenu> {
  final List<Views> views = [
    Views(Icons.book_outlined, "Notas", const NotesScreen()),
    Views(Icons.hourglass_empty_outlined, "Horario", const TimableScreen()),
    Views(Icons.calendar_today_outlined, "Agenda", const ScheduleScreen()),
    Views(Icons.label_outline, "Etiquetas", const LabelsScreen()),
    Views(Icons.timer_outlined, "Pomodoro", const PomodoroScreen()),
    Views(Icons.delete_outline, "Papelera", const DeletedTask()),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MyAppName',
                style: GoogleFonts.roboto(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              ListView.separated(
                shrinkWrap: true,
                itemCount: views.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 5),
                itemBuilder: (BuildContext context, int index) {
                  Views view = views[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    selected: _currentSelected == index ? true : false,
                    title: Text(view.title),
                    leading: Icon(view.icon),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => view.screen,
                        ),
                      );
                      setState(() {
                        _currentSelected = index;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
