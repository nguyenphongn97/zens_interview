class Calculation{
  String miniMaxSum(List<int> arr) {
    if(arr.length != 5 ) {
      return "";
    }

    arr.sort();
    final minSum = arr.sublist(0, 4).reduce((a, b) => a + b);
    final maxSum = arr.sublist(1, 5).reduce((a, b) => a + b);

    return'$minSum $maxSum';
  }
}
