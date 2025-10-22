import 'package:arrived_at_work/utils/current_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCheckingIn = false;

  void _handleCheckIn() {
    setState(() {
      isCheckingIn = true;
    });
    // Add your check-in logic here

    final now = DateTime.now();
    print('출근 시간: $now');

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isCheckingIn = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(
            '출근이 완료되었습니다! ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arrived at Work')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // 실시간 시계
              const CurrentTimeWidget(showSeconds: true, separator: ':'),
              // TODO: 오늘의 명언을 업데이트하는 기능 추가
              const Text(
                'The future starts today, not tomorrow.',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Lottie.asset(
                'assets/walk cycling shoes.json',
                width: widget.screenWidth * 0.7,
              ),
              ElevatedButton.icon(
                label: const Text('출근시간 찍기!', style: TextStyle(fontSize: 24)),
                icon: const Icon(
                  Icons.verified_outlined,
                  size: 34,
                  color: Colors.green,
                ),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: widget.screenWidth * 0.1,
                    ),
                  ),
                ),
                onPressed: _handleCheckIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
