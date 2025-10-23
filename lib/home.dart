import 'package:arrived_at_work/utils/current_location.dart';
import 'package:arrived_at_work/utils/current_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // bool isCheckingIn = false;
  bool _isLoading = false;
  Future<Position>? _locationFuture;

  void _onButtonPressed() {
    setState(() {
      _isLoading = true;
      _locationFuture = determinePosition();
    });
  }

  // Future<String?> _handleCheckIn() async {
  //   setState(() {
  //     isCheckingIn = true;
  //   });

  //   // 현재 위도, 경도
  //   final Position? currentPosition = await determinePosition();
  //   final double? currentLatitude = currentPosition?.latitude;
  //   final double? currentLongitude = currentPosition?.longitude;

  //   // 목표 지점
  //   const double startLatitude = 37.485743;
  //   const double startLongitude = 127.029160;

  //   // 두 지점 간의 거리 계산 (m)
  //   double distanceInMeters = Geolocator.distanceBetween(
  //     startLatitude,
  //     startLongitude,
  //     currentLatitude!,
  //     currentLongitude!,
  //   );

  // if (!_inWorkLocation(distanceInMeters)) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       backgroundColor: Colors.redAccent,
  //       content: Text(
  //         '출근 지점에서 멀리 떨어져 있습니다. 다시 시도해주세요.',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 20),
  //       ),
  //     ),
  //   );
  // } else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       backgroundColor: Colors.green,
  //       content: Text(
  //         '출근 시간이 기록되었습니다!',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 20),
  //       ),
  //     ),
  //   );
  // }
  // setState(() {
  //   isCheckingIn = false;
  // });
  // return distanceInMeters.toString();
  // }

  // final now = DateTime.now();

  // bool _inWorkLocation(double distanceInMeters) {
  //   // 반경 10미터 이내인지 확인
  //   return distanceInMeters <= 10;
  // }

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

              const Placeholder(),

              // TODO : 애니메이션 추가
              // Lottie.asset(
              //   'assets/walk cycling shoes.json',
              //   width: widget.screenWidth * 0.7,
              // ),
              _isLoading
                  ? FutureBuilder<Position>(
                      future: _locationFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            strokeWidth: 6,
                            strokeCap: StrokeCap.round,
                          );
                        } else if (snapshot.hasError) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('에러: ${snapshot.error}'),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () =>
                                    setState(() => _isLoading = false),
                                child: const Text('다시 시도'),
                              ),
                            ],
                          );
                        } else if (snapshot.hasData) {
                          final position = snapshot.data!;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Current Position\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () =>
                                    setState(() => _isLoading = false),
                                child: const Text('다시 가져오기'),
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    )
                  : TextButton(
                      onPressed: _onButtonPressed,
                      child: const Text('Click'),
                    ),

              // ElevatedButton.icon(
              //   label: const Text('출근시간 찍기!', style: TextStyle(fontSize: 24)),
              //   icon: const Icon(
              //     Icons.verified_outlined,
              //     size: 34,
              //     color: Colors.green,
              //   ),
              //   style: ButtonStyle(
              //     padding: WidgetStateProperty.all(
              //       EdgeInsets.symmetric(
              //         vertical: 12,
              //         horizontal: widget.screenWidth * 0.1,
              //       ),
              //     ),
              //   ),
              //   onPressed: _handleCheckIn,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
