import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_1/provider/provider.dart';

class WeatherPage extends StatefulWidget {
  final String city;

  const WeatherPage({required this.city, super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  void _refreshWeather() async {
    var weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.fetchWeather(widget.city);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 208, 208),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Weather for ${widget.city}',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: weatherProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : weatherProvider.errorMessage != null
              ? Center(child: Text(weatherProvider.errorMessage!))
              : weatherProvider.weather == null
                  ? Center(child: Text('No weather data'))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                            Text(
                              weatherProvider.weather!.name ?? '',
                              style: TextStyle(
                                  fontSize: 30.sp, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Text(
                          '${((weatherProvider.weather!.main?.temp ?? 0) - 273.15).toStringAsFixed(1)}°C',
                          style: TextStyle(
                              fontSize: 50.sp, fontWeight: FontWeight.w600),
                        ),
                        
                         if (weatherProvider.weather!.weather != null &&
                            weatherProvider.weather!.weather!.isNotEmpty)
                          Column(
                            children: [
                              Image.network(
                                'http://openweathermap.org/img/wn/${weatherProvider.weather!.weather![0].icon}@4x.png',
                                width: 200.w,
                                height: 120.h,
                              ),
                              Text(
                                weatherProvider.weather!.weather![0].description ?? '',
                                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        Gap(20.h),
                        Container(
                          height: 100.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            color: Color.fromARGB(255, 0, 140, 255),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Humidity: ${weatherProvider.weather!.main?.humidity?.toString()}%',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(10.w),
                              Text(
                                'Wind speed: ${weatherProvider.weather!.wind?.speed?.toString()} m/s',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                        Gap(25.h),
                               ElevatedButton(
                          onPressed: _refreshWeather,
                          child: Icon(Icons.refresh),
                        ),
                      ],
                    ),
    );
  }
}
