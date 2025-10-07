import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/color.dart';
import '../../presentation/widgets/add_edit_pop_up.dart';
import '../provider/bloc/todobloc/todo_bloc.dart';

class AddSearchSectionSection extends StatefulWidget {
  const AddSearchSectionSection({super.key});

  @override
  State<AddSearchSectionSection> createState() => _AddSearchSectionSectionState();
}

class _AddSearchSectionSectionState extends State<AddSearchSectionSection> {

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(width: double.infinity, height: height * 0.13),
            Container(
              width: double.infinity,
              height: height * 0.075,
              color: Colors.black,
            ),
            Positioned(
              top: height * 0.03,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.7,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: boxColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            context.read<TodoBloc>().add(SearchTodoEvent(value));
                          },
                          decoration: InputDecoration(
                            hintText: ' 🚀 Search...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddEditPopup(

                          ),
                        );
                      },
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: primary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Add'),
                            Icon(Icons.add_circle_outline_rounded),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
