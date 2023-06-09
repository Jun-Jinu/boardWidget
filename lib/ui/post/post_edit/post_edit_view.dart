import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:getwidget/getwidget.dart';

import 'package:board_widget/data/model/post/post.dart';
import './post_edit_viewmodel.dart';

class PostEditView extends StatefulWidget {
  const PostEditView({Key? key}) : super(key: key);

  @override
  _PostEditViewState createState() => _PostEditViewState();
}

class _PostEditViewState extends State<PostEditView>
    with SingleTickerProviderStateMixin {
  late PostEditViewModel viewModel;
  late Post post;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<PostEditViewModel>(context);
    post = ModalRoute.of(context)!.settings.arguments as Post;

    viewModel.onLoadPost(post);

    return WillPopScope(
      onWillPop: () async {
        viewModel.onDisposePost();
        viewModel.delControllerValue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('일기 수정하기'),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: viewModel.onToggleCalendar,
                    child: Container(
                      width: 300,
                      height: 60.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        viewModel.formattedDate,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    height: viewModel.showCalendar ? 400 : 0,
                    duration: Duration(milliseconds: 250),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TableCalendar(
                            locale: 'ko-KR',
                            firstDay: DateTime.utc(2021, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: viewModel.focusedDay,
                            selectedDayPredicate: (DateTime day) {
                              return isSameDay(viewModel.selectedDay, day);
                            },
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            calendarBuilders: CalendarBuilders(
                              dowBuilder: (context, day) {
                                return Center(
                                    child: Text(viewModel.days[day.weekday]));
                              },
                            ),
                            onDaySelected: viewModel.onDaySelected,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: viewModel.onPressdConfirm,
                                child: Text(
                                  '확인',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "오늘 내 기분의 날씨는",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          viewModel.selectedWeatherIndex == 0
                              ? CupertinoIcons.flame_fill
                              : CupertinoIcons.flame,
                        ),
                        color: viewModel.selectedWeatherIndex == 0
                            ? Colors.deepOrange
                            : null,
                        onPressed: () => viewModel.onChangeWeather(0),
                      ),
                      IconButton(
                        icon: Icon(
                          viewModel.selectedWeatherIndex == 1
                              ? CupertinoIcons.sun_max_fill
                              : CupertinoIcons.sun_min,
                        ),
                        color: viewModel.selectedWeatherIndex == 1
                            ? Colors.orange
                            : null,
                        onPressed: () => viewModel.onChangeWeather(1),
                      ),
                      IconButton(
                        icon: Icon(
                          viewModel.selectedWeatherIndex == 2
                              ? CupertinoIcons.cloud_sun_fill
                              : CupertinoIcons.cloud_sun,
                        ),
                        color: viewModel.selectedWeatherIndex == 2
                            ? Colors.lightBlue
                            : null,
                        onPressed: () => viewModel.onChangeWeather(2),
                      ),
                      IconButton(
                        icon: Icon(
                          viewModel.selectedWeatherIndex == 3
                              ? CupertinoIcons.cloud_rain_fill
                              : CupertinoIcons.cloud_rain,
                        ),
                        color: viewModel.selectedWeatherIndex == 3
                            ? Colors.blueGrey
                            : null,
                        onPressed: () => viewModel.onChangeWeather(3),
                      ),
                      IconButton(
                        icon: Icon(
                          viewModel.selectedWeatherIndex == 4
                              ? CupertinoIcons.moon_stars_fill
                              : CupertinoIcons.moon_stars,
                        ),
                        color: viewModel.selectedWeatherIndex == 4
                            ? Colors.amber
                            : null,
                        onPressed: () => viewModel.onChangeWeather(4),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      hintText: "일기",
                      errorStyle: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    maxLines: 10,
                    controller: viewModel.contentController,
                    validator: viewModel.validateContent,
                    onSaved: viewModel.onSavedContent,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      hintText: "오늘의 다짐",
                      errorStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    controller: viewModel.promiseController,
                    validator: viewModel.validatePromise,
                    onSaved: viewModel.onSavedPromise,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: viewModel.onToggleCheckbox,
                    child: Row(
                      children: [
                        GFCheckbox(
                          customBgColor:
                              Theme.of(context).colorScheme.secondary,
                          size: GFSize.SMALL,
                          type: GFCheckboxType.custom,
                          onChanged: viewModel.onCheckboxChanged,
                          value: viewModel.isCheckedWidgetText,
                          inactiveIcon: null,
                        ),
                        Container(
                          child: Text(
                            '해당 다짐을 나의 핵심 목표로 선택합니다.',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            await viewModel.updatePost(context);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          '수정하기',
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
