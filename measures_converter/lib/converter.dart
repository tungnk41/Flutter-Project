class Converter{

  final Map<String, double> measuresMap = {
    "meters" : 1,
    "kilometers" : 1000,
    "miles" : 1609.34,
  };


  String convert(double inputValue, String from, String to){
    double result = (inputValue*measuresMap[from]!)/measuresMap[to]!;
    return result.toString();
  }
}