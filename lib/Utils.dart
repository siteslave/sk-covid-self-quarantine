
import 'package:intl/intl.dart';

class Utils {

  Utils();

  String toThaiDate(DateTime date) {
    // create format
    var strDate = new DateFormat.MMMd('th_TH').format(date);
    var _strDate = '$strDate ${date.year + 543}';
    // return thai date
    return _strDate;
  }

  String toLongThaiDate(DateTime date) {
    // create format
    var strDate = new DateFormat.MMMMd('th_TH').format(date);
    var _strDate = '$strDate ${date.year + 543}';
    // return thai date
    return _strDate;
  }

}