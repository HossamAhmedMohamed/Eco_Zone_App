import 'dart:math';

import 'package:flutter/material.dart';

class FishAndPlantsStatus extends StatefulWidget {
  const FishAndPlantsStatus({super.key});

  @override
  State<FishAndPlantsStatus> createState() => _FishAndPlantsStatusState();
}

class _FishAndPlantsStatusState extends State<FishAndPlantsStatus> {
  final List<String> fishStatusList = [
    "The fish are active and eating well.",
    "Some fish are moving slowly.",
    "There are fish that are not moving or are having health issues.",
    "The fish show signs of poisoning or injury.",
    "The fish are in critical condition.",
  ];

  final List<String> plantStatusList = [
    "Healthy growth with green leaves.",
    "Some leaves are starting to yellow.",
    "Growth has stopped, lack of nutrients.",
    "Some leaves show signs of stress.",
    "The plants urgently need nutrients.",
  ];

  final List<String> feedingTimeList = [
    "The last feeding was 2 hours ago.",
    "The fish were fed 4 hours ago.",
    "The last feeding was 1 hour ago.",
  ];

  final List<String> dailyFoodList = [
    "Remaining daily food: 15 grams out of 50 grams.",
    "35 grams consumed, 15 grams remaining for today.",
    "Daily food: 60 grams, 30 grams remaining.",
  ];

  final List<String> foodTypeList = [
    "Food used: Flake - suitable for rapid growth.",
    "Food type: Natural Mix - rich in minerals and vitamins.",
    "Food: Shrimp-based - supports immunity and growth.",
  ];

  final List<String> feedingWarningsList = [
    "The food was not fully consumed, check fish health.",
    "The fish are consuming food slowly, check the tank environment.",
    "Feeding rate is within the normal range.",
    "Food consumption is high today, ensure stock is sufficient.",
    "Excess food remnants observed, adjust feeding amount.",
  ];

  final List<String> swimmingActivityList = [
    "85% of the fish are active and swimming freely.",
    "75% of the fish are actively swimming.",
    "90% of the fish show normal swimming behavior.",
  ];

  final List<String> swimmingSpeedList = [
    "Swimming speed: High - 1.5 m/s.",
    "Medium speed - 1.1 m/s.",
    "Low swimming speed - 0.9 m/s.",
  ];

  final List<String> stillnessRateList = [
    "15% of the fish are moving slowly.",
    "Only 5% of the fish are inactive.",
    "20% of the fish are temporarily still.",
  ];

  final List<String> swimmingWarningsList = [
    "A decrease in movement of some fish detected, check water quality and oxygen levels.",
    "Fish movement is slower than usual, check temperature and ammonia levels.",
    "Swimming rate is normal with no unusual behavior.",
    "Fish are in good activity condition.",
    "Slight decrease in activity, monitor situation over the next few hours.",
  ];

  final List<String> growthRateList = [
    "Average length: 9 cm (increase of 0.4 cm from last week).",
    "Current length: 8 cm (increase of 0.2 cm from last week).",
    "Current fish length: 8.7 cm (increase of 0.5 cm from last week).",
  ];

  final List<String> averageWeightList = [
    "Average weight: 125 grams (increase of 7 grams from last week).",
    "Current weight: 118 grams (increase of 4 grams).",
    "Current weight: 122 grams (increase of 3 grams this week).",
  ];

  final List<String> growthPercentageList = [
    "Growth rate: +5% weekly.",
    "Fish growth: +3% compared to last week.",
    "Fish growth increased by 4% this week.",
  ];

  final List<String> growthWarningsList = [
    "Growth is within the normal range.",
    "Growth is below expectations, check feeding and water quality.",
    "Slight increase in growth, check environmental conditions.",
    "Growth increase is good, no need to worry.",
  ];

  String fishStatus = "The fish are active and eating well.";
  String plantStatus = "Healthy growth with green leaves.";
  String feedingTime = "The last feeding was 2 hours ago.";
  String dailyFood = "Remaining daily food: 15 grams out of 50 grams.";
  String foodType = "Food used: Flake - suitable for rapid growth.";
  String feedingWarning = "Feeding rate is within the normal range.";
  String swimmingActivity = "85% of the fish are active and swimming freely.";
  String swimmingSpeed = "Swimming speed: High - 1.5 m/s.";
  String stillnessRate = "15% of the fish are moving slowly.";
  String swimmingWarning =
      "A decrease in movement of some fish detected, check water quality and oxygen levels.";
  String growthRate =
      "Average length: 9 cm (increase of 0.4 cm from last week).";
  String averageWeight =
      "Average weight: 125 grams (increase of 7 grams from last week).";
  String growthPercentage = "Growth rate: +5% weekly.";
  String growthWarning = "Growth is within the normal range.";

  String fishType = '';
  String fishCount = '';
  String plantType = '';
  String plantCount = '';

  final Random random = Random();

  void _updateStatus() {
    setState(() {
      fishStatus = fishStatusList[random.nextInt(fishStatusList.length)];
      plantStatus = plantStatusList[random.nextInt(plantStatusList.length)];
      feedingTime = feedingTimeList[random.nextInt(feedingTimeList.length)];
      dailyFood = dailyFoodList[random.nextInt(dailyFoodList.length)];
      foodType = foodTypeList[random.nextInt(foodTypeList.length)];
      feedingWarning =
          feedingWarningsList[random.nextInt(feedingWarningsList.length)];
      swimmingActivity =
          swimmingActivityList[random.nextInt(swimmingActivityList.length)];
      swimmingSpeed =
          swimmingSpeedList[random.nextInt(swimmingSpeedList.length)];
      stillnessRate =
          stillnessRateList[random.nextInt(stillnessRateList.length)];
      swimmingWarning =
          swimmingWarningsList[random.nextInt(swimmingWarningsList.length)];
      growthRate = growthRateList[random.nextInt(growthRateList.length)];
      averageWeight =
          averageWeightList[random.nextInt(averageWeightList.length)];
      growthPercentage =
          growthPercentageList[random.nextInt(growthPercentageList.length)];
      growthWarning =
          growthWarningsList[random.nextInt(growthWarningsList.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    _updateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Biological System')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fish and Plant Status',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildGradientCard('Fish', fishStatus),
            SizedBox(height: 20),
            _buildGradientCard('Plants', plantStatus),
            SizedBox(height: 30),
            Text(
              'Feeding',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildGradientCard('Last Feeding', feedingTime),
            SizedBox(height: 20),
            _buildGradientCard('Daily Food Amount', dailyFood),
            SizedBox(height: 20),
            _buildGradientCard('Food Type', foodType),
            SizedBox(height: 20),
            _buildGradientCard('Feeding Warnings', feedingWarning),
            SizedBox(height: 30),
            Text(
              'Swimming Activity',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildGradientCard('Swimming Activity Rate', swimmingActivity),
            SizedBox(height: 20),
            _buildGradientCard('Swimming Speed', swimmingSpeed),
            SizedBox(height: 20),
            _buildGradientCard('Stillness Rate', stillnessRate),
            SizedBox(height: 20),
            _buildGradientCard('Swimming Warnings', swimmingWarning),
            SizedBox(height: 30),
            Text(
              'Growth Rate',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildGradientCard('Growth Rate', growthRate),
            SizedBox(height: 20),
            _buildGradientCard('Average Weight', averageWeight),
            SizedBox(height: 20),
            _buildGradientCard('Growth Percentage', growthPercentage),
            SizedBox(height: 20),
            _buildGradientCard('Growth Warnings', growthWarning),
            SizedBox(height: 30),
            Text(
              'Add Fish and Plants',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTextField('Fish Type', fishType),
            SizedBox(height: 20),
            _buildTextField('Number of Fish', fishCount),
            SizedBox(height: 20),
            _buildTextField('Plant Type', plantType),
            SizedBox(height: 20),
            _buildTextField('Number of Plants', plantCount),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientCard(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink, Colors.purple, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: (text) {
        setState(() {
          value = text;
        });
      },
    );
  }
}
