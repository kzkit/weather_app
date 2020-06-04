part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;

  WeatherChanged({@required this.weatherCondition})
      : assert(weatherCondition != null);

  @override
  List<Object> get props => [weatherCondition];
}
