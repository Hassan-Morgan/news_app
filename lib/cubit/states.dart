abstract class AppStates{}

class InitialState extends AppStates{}
class ChangeBottomNavigationBar extends AppStates{}
class LoadingData extends AppStates{}
class GetDataSuccess extends AppStates{}
class GetDataError extends AppStates{
  final String onError;
  GetDataError(this.onError);
}
class ChangeAppTheme extends AppStates{}
class GetDataFromDatabase extends AppStates{}
