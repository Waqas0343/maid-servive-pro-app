import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_maids_pro/app_assets/app_styles/my_colors.dart';
import '../app_common_widget/custom_card.dart';
import 'controllers/user_availability_controller.dart';
import 'models/set_user_availbility_model.dart';

class UserAvailabilityScreen extends StatelessWidget {
  const UserAvailabilityScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final UserAvailabilityController controller =
        Get.put(UserAvailabilityController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Set Your Availability"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Row(
                  children: [
                    Icon(Icons.list_alt_outlined),
                    SizedBox(width: 5),
                    Text('ListView'),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 5),
                    Text('CalendarView'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListViewTab(controller: controller),
            CalendarViewTab(controller: controller),
          ],
        ),
      ),
    );
  }
}

class ListViewTab extends StatelessWidget {
  final UserAvailabilityController controller;

  const ListViewTab({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : controller.userAvailabilityList.isEmpty
              ? Center(
                  child: Text("No Data Found..."),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4,
                        ),
                        itemCount: 7,
                        itemBuilder: (_, int index) {
                          List<Day> dayList;
                          String dayName;
                          switch (index) {
                            case 0:
                              dayList =
                                  controller.userAvailabilityList[0].monday;
                              dayName = 'Monday';
                              break;
                            case 1:
                              dayList =
                                  controller.userAvailabilityList[0].tuesday;
                              dayName = 'Tuesday';
                              break;
                            case 2:
                              dayList =
                                  controller.userAvailabilityList[0].wednesday;
                              dayName = 'Wednesday';
                              break;
                            case 3:
                              dayList =
                                  controller.userAvailabilityList[0].thursday;
                              dayName = 'Thursday';
                              break;
                            case 4:
                              dayList =
                                  controller.userAvailabilityList[0].friday;
                              dayName = 'Friday';
                              break;
                            case 5:
                              dayList =
                                  controller.userAvailabilityList[0].saturday;
                              dayName = 'Saturday';
                              break;
                            case 6:
                              dayList =
                                  controller.userAvailabilityList[0].sunday;
                              dayName = 'Sunday';
                              break;
                            default:
                              dayList = [];
                              dayName = '';
                          }

                          return CustomCard(
                            color: MyColors.lightBorderColor,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        dayName,
                                        style:
                                            Get.textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: dayList.isNotEmpty
                                              ? Colors.blue
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(
                                        dayList.length,
                                        (i) => ListTile(
                                          title: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Obx(
                                                    () => Checkbox(
                                                      value: dayList[i]
                                                              .status
                                                              .value ==
                                                          "1",
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          controller
                                                              .saveNewUserAvailabilitySlot(
                                                            id: dayList[i].id,
                                                            slotId: dayList[i]
                                                                .slotId,
                                                            dayName: dayName
                                                                .substring(
                                                                    0, 3),
                                                            slotStartTime:
                                                                dayList[i]
                                                                    .slotStartTime,
                                                            slotEndTime:
                                                                dayList[i]
                                                                    .slotEndTime,
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Text(
                                                    'Unavailable',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Obx(
                                                      () =>
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          labelText:
                                                              'Available from',
                                                          labelStyle: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        value: controller
                                                                .selectedStartTimes[
                                                            index][i],
                                                        items: controller
                                                            .timeSlots
                                                            .map((time) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: time,
                                                            child: Text(time),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          controller
                                                              .setSelectedStartTime(
                                                                  index,
                                                                  i,
                                                                  newValue!);
                                                          controller
                                                              .saveNewUserAvailabilitySlot(
                                                            id: dayList[i].id,
                                                            slotId: dayList[i]
                                                                .slotId,
                                                            dayName: dayName
                                                                .substring(
                                                                    0, 3),
                                                            slotStartTime:
                                                                controller
                                                                        .selectedStartTimes[
                                                                    index][i],
                                                            slotEndTime: controller
                                                                    .selectedEndTimes[
                                                                index][i],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Obx(
                                                      () =>
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Available Till',
                                                          border:
                                                              InputBorder.none,
                                                          labelStyle: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        value: controller
                                                                .selectedEndTimes[
                                                            index][i],
                                                        items: controller
                                                            .timeSlots
                                                            .map((time) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: time,
                                                            child: Text(time),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          controller
                                                              .setSelectedEndTime(
                                                                  index,
                                                                  i,
                                                                  newValue!);
                                                          controller
                                                              .saveNewUserAvailabilitySlot(
                                                            id: dayList[i].id,
                                                            slotId: dayList[i]
                                                                .slotId,
                                                            dayName: dayName
                                                                .substring(
                                                                    0, 3),
                                                            slotStartTime:
                                                                controller
                                                                        .selectedStartTimes[
                                                                    index][i],
                                                            slotEndTime: controller
                                                                    .selectedEndTimes[
                                                                index][i],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      controller
                                                          .deleteWeekDaySlot(
                                                              dayList[i].id);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 100,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Positioned(
                                  bottom: -10,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      if (dayList.length < 2) {
                                        controller.addTimeSlot(index);
                                        int randomIndex = Random().nextInt(
                                            controller.timeSlots.length);
                                        String? selectedStartTime =
                                            controller.timeSlots[randomIndex];
                                        String? selectedEndTime =
                                            controller.timeSlots[randomIndex];
                                        var random = Random.secure();
                                        var bytes = List.generate(
                                            16, (index) => random.nextInt(256));
                                        var slotId = base64Url.encode(bytes);
                                        bytes = List.generate(
                                            16, (index) => random.nextInt(256));
                                        var id = base64Url.encode(bytes);
                                        controller
                                            .saveNewUserAvailabilitySlotWithRandomId(
                                          id: id,
                                          slotId: slotId,
                                          dayName: dayName.substring(0, 3),
                                          slotStartTime: selectedStartTime,
                                          slotEndTime: selectedEndTime,
                                        );
                                      } else {
                                        Get.snackbar('Limit Reached',
                                            'You can only add up to 2 slots per day.',
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

class CalendarViewTab extends StatefulWidget {
  final UserAvailabilityController controller;

  CalendarViewTab({required this.controller});

  @override
  _CalendarViewTabState createState() => _CalendarViewTabState();
}

class _CalendarViewTabState extends State<CalendarViewTab> {
  DateTime _currentDate = DateTime.now();

  void _incrementMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
  }

  void _decrementMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
  }

  void _goToToday() {
    setState(() {
      _currentDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : widget.controller.userAvailabilityList.isEmpty
              ? Center(
                  child: Text("No Data Found..."),
                )
              : Column(
                  children: [
                    _buildMonthYearHeader(),
                    Expanded(child: _buildCalendar(widget.controller)),
                  ],
                ),
    );
  }

  Widget _buildMonthYearHeader() {
    String month = _getMonthName(_currentDate.month);
    String year = _currentDate.year.toString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _decrementMonth,
          ),
          Text(
            '$month $year',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _goToToday,
                child: Text('Today'),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: _incrementMonth,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Widget _buildCalendar(UserAvailabilityController controller) {
    final daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    int daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    int firstWeekdayOfMonth =
        DateTime(_currentDate.year, _currentDate.month, 1).weekday % 7;
    int totalGridCells = daysInMonth + firstWeekdayOfMonth;

    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.6,
      ),
      itemCount: totalGridCells + 7,
      itemBuilder: (context, index) {
        if (index < 7) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey[200],
            ),
            child: Text(
              daysOfWeek[index],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          );
        } else {
          int dayIndex = index - 7;
          if (dayIndex < firstWeekdayOfMonth) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
            );
          } else {
            int dayNumber = dayIndex - firstWeekdayOfMonth + 1;
            DateTime currentDay =
                DateTime(_currentDate.year, _currentDate.month, dayNumber);
            List<String> availableTimes =
                _getAvailableTimesForDay(currentDay, controller);

            bool isToday = currentDay.day == DateTime.now().day &&
                currentDay.month == DateTime.now().month &&
                currentDay.year == DateTime.now().year;

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                color: isToday ? Colors.lightGreen[100] : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$dayNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isToday ? Colors.green : Colors.black,
                      ),
                    ),
                    ...availableTimes
                        .map(
                          (time) => Container(
                            margin: EdgeInsets.only(top: 2.0),
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  List<String> _getAvailableTimesForDay(
      DateTime day, UserAvailabilityController controller) {
    List<String> availableTimes = [];

    controller.userAvailabilityList.forEach((userAvailability) {
      switch (day.weekday) {
        case DateTime.sunday:
          availableTimes.addAll(_getTimesForDay(userAvailability.sunday));
          break;
        case DateTime.monday:
          availableTimes.addAll(_getTimesForDay(userAvailability.monday));
          break;
        case DateTime.tuesday:
          availableTimes.addAll(_getTimesForDay(userAvailability.tuesday));
          break;
        case DateTime.wednesday:
          availableTimes.addAll(_getTimesForDay(userAvailability.wednesday));
          break;
        case DateTime.thursday:
          availableTimes.addAll(_getTimesForDay(userAvailability.thursday));
          break;
        case DateTime.friday:
          availableTimes.addAll(_getTimesForDay(userAvailability.friday));
          break;
        case DateTime.saturday:
          availableTimes.addAll(_getTimesForDay(userAvailability.saturday));
          break;
      }
    });

    return availableTimes;
  }

  List<String> _getTimesForDay(List<Day> dayList) {
    return dayList
        .map((day) => '${day.slotStartTime} - ${day.slotEndTime}')
        .toList();
  }
}
