import 'package:logger/logger.dart';

final logger=Logger(printer: CustomerPrinter());
class CustomerPrinter extends LogPrinter{
  @override
  List<String> log(LogEvent event) {
    // TODO: implement log
    final color=PrettyPrinter.levelColors[event.level];
    final emoji=PrettyPrinter.levelEmojis[event.level];
    final message=event.message;
    return [color!('$emoji:$message')];
  }

}