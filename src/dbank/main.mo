import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// create a new canister
actor DBank{
  stable var currentBalance: Float = 300;
  currentBalance := 300;

  stable var startTime = Time.now();
  startTime := Time.now();

  // credit account
  public func topUp(amount: Float) {
    currentBalance += amount;
    Debug.print(debug_show(currentBalance));
  };

  // debit account
  public func withdraw(amount: Float){
    let tempValue: Float = currentBalance - amount;

    if(tempValue >= 0){
      currentBalance -= amount;
      Debug.print(debug_show(currentBalance));
    }else{
      Debug.print("Invalid calculation");
    }
  };

  // check balance
  public query func checkBalance(): async Float{
      return currentBalance;
  };

  // calculate compount interest
  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNs = currentTime - startTime;
    let timeElapsedS = timeElapsedNs / 1000000000; // time elapsed in seconds
    currentBalance := currentBalance * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  }
}