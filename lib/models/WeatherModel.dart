class WeatherForecast {
  final List<WeatherForecastItem> days;
  WeatherForecast({
    this.days = const [],
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json){
    List<Map<String, dynamic>> days = new List<Map<String, dynamic>>.from(json['daily']);
    return WeatherForecast(
        days: days.map((e) => WeatherForecastItem.fromJson(e)).toList()
    );
  }
}


class WeatherForecastItem {
  final double temperature;
  final double min;
  final double max;
  final double wind_speed;
  final int humidity;
  final int dt;
  final int sunrise;
  final int sunset;
  final String icon;
  WeatherForecastItem({
    this.temperature = 0.0,
    this.icon = '01d',
    this.min = 0.0,
    this.max = 0.0,
    this.dt = 0,
    this.sunrise = 0,
    this.sunset = 0,
    this.wind_speed = 0.0,
    this.humidity = 0
  });

  factory WeatherForecastItem.fromJson(Map<String, dynamic> json){
    print(json['weather']);
    return WeatherForecastItem(
        temperature: json['temp']['day'],
        icon: json['weather'][0]['icon'],
        min: json['temp']['min'],
        max: json['temp']['max'],
        dt: json['dt'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        wind_speed: json['wind_speed'],
        humidity: json['humidity']
    );
  }

}