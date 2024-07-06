import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_1/provider/provider.dart';
import 'package:weather_app_1/screens/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(
            fontSize: 34.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Consumer<WeatherProvider>(
        builder: (context,weatherProvider,b) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Fill this feild";
                      }
                      return null;
                    },
                    controller: cityController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Choose Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Gap(20.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<WeatherProvider>(context, listen: false)
                            .fetchWeather(cityController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WeatherPage(city: cityController.text),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Enter Location'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Text('Search'),
                  ),
                  Gap(30.h),
          
                   if (weatherProvider.weather != null)
                          Column(
                            children: [
                              Gap(20.h),
                              Text(
                                'Last Searched Location:',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Gap(10.h),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    weatherProvider.weather!.name ?? '',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                   Gap(10.h),
                                   Text(
                                '-${((weatherProvider.weather!.main?.temp ?? 0) - 273.15).toStringAsFixed(1)}°C',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                                ],
                              ),
                             
                             
                            ],
                          ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
