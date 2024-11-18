import 'package:flutter/material.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  int _selectedIndex = 0;

  
  final List<Widget> _pages = [
    CurrentWeatherPage(),
    WeatherForecastPage(),
  ];

  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Current Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Forecast',
          ),
        ],
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped, 
      ),
    );
  }
}

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  String _cityName = 'Karachi,Sindh';
  String _weatherDescription = 'Cloudy';
  double _temperature = 18.5;
  String _weatherIcon = '🌥';

  final List<Map<String, dynamic>> _cities = [
    {'name': 'Karachi,Sindh', 'description': 'Cloudy', 'temperature': 18.5, 'icon': '🌥'},
    {'name': 'Hyderabad,Sindh', 'description': 'Sunny', 'temperature': 22.0, 'icon': '☀️'},
    {'name': 'Lahore', 'description': 'Rainy', 'temperature': 15.0, 'icon': '🌧'},
    {'name': 'Multan', 'description': 'Clear', 'temperature': 25.0, 'icon': '☀️'},
  ];

  void _updateWeather(String city) {
    final cityData = _cities.firstWhere(
      (item) => item['name'].toLowerCase() == city.toLowerCase(),
      orElse: () => _cities[0],
    );

    setState(() {
      _cityName = cityData['name'];
      _weatherDescription = cityData['description'];
      _temperature = cityData['temperature'];
      _weatherIcon = cityData['icon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _updateWeather,
            ),
            SizedBox(height: 20),
            Text(
              _cityName,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _weatherIcon,
              style: TextStyle(fontSize: 64),
            ),
            SizedBox(height: 10),
            Text(
              '$_temperature°C',
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 10),
            Text(
              _weatherDescription,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherForecastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    List<Map<String, dynamic>> forecastData = [
      {'day': 'Monday', 'icon': '☀️', 'temp': 20.0},
      {'day': 'Tuesday', 'icon': '🌧', 'temp': 15.0},
      {'day': 'Wednesday', 'icon': '☁️', 'temp': 18.0},
      {'day': 'Thursday', 'icon': '🌦', 'temp': 16.5},
      {'day': 'Friday', 'icon': '⛅️', 'temp': 19.0},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: forecastData.length,
      itemBuilder: (context, index) {
        final item = forecastData[index];
        return ListTile(
          leading: Text(
            item['icon'],
            style: TextStyle(fontSize: 32),
          ),
          title: Text(item['day']),
          trailing: Text('${item['temp']}°C'),
        );
      },
    );
  }
}