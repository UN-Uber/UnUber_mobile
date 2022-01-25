import 'package:stacked/stacked.dart';

class VariablesSelectViewModel extends BaseViewModel {
  List<String> titles = ['Uber Ya', 'Uber Eco', 'Uber Comfort', 'Uber X'],
      prices = ['10.153', '12.768', '14.423', '16.542'];
  int selectedIndex = -1;

  update() {
    notifyListeners();
  }
}
