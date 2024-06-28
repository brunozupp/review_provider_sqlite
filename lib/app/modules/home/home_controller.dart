import 'package:review_provider_sqlite/app/core/notifier/default_change_notifier.dart';
import 'package:review_provider_sqlite/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {
  
  var filterSelected = TaskFilterEnum.today;
}