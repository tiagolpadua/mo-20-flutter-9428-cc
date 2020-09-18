class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  // Implement toString
  // ALT+insert -> toString
  @override
  String toString() {
    return 'Transfer{value: $value, accountNumber: $accountNumber}';
  }
}