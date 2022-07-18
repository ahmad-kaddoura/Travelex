
class Functions{
  static Functions instance = Functions();
  static bool rev = false;
  //for settings icon animation (Left/Right) in MyVisits Page
  void setReverseStatus(bool isReversed){
    rev = isReversed;
  }
  bool getReverseStatus(){
    return rev;
  }
  //------
}