class Transactions {
  double amount;
  double price;
  String code;
  DateTime dateTime;
  String destination;
  String type;

  Transactions(
      {this.amount,
      this.dateTime,
      this.destination,
      this.code,
      this.price,
      this.type});
}

List<Transactions> transactions = [
  Transactions(
    amount: 0.52842,
    price: 9537.64145,
    code: "BTC",
    dateTime: DateTime(2020, 8, 10, 10),
    destination: "BTC account",
    type: "Received",
  ),
  Transactions(
    amount: 0.52842,
    price: 9537.64145,
    code: "BTC",
    dateTime: DateTime(2020, 8, 10, 9),
    destination: "BTC account",
    type: "Received",
  ),
  Transactions(
    amount: 0.52842,
    price: 9537.64145,
    code: "BTC",
    dateTime: DateTime(2020, 8, 10, 8),
    destination: "BTC account",
    type: "Received",
  ),
  Transactions(
    amount: 19.56812,
    price: 0.25467,
    code: "BAT",
    dateTime: DateTime(2020, 5, 1, 5),
    destination: "BAT account",
    type: "Received",
  ),
  Transactions(
    amount: 1.98842,
    price: 183.23546,
    code: "BCH",
    dateTime: DateTime(2020, 8, 8, 6),
    destination: "BCH account",
    type: "Sent",
  ),
  Transactions(
    amount: 1.98842,
    price: 183.23546,
    code: "BCH",
    dateTime: DateTime(2020, 8, 8, 14),
    destination: "BCH account",
    type: "Sent",
  ),
  Transactions(
    amount: 0.52842,
    price: 9537.64145,
    code: "BTC",
    dateTime: DateTime(2020, 8, 10, 8),
    destination: "BTC account",
    type: "Received",
  ),
  Transactions(
    amount: 19.56812,
    price: 0.25467,
    code: "BAT",
    dateTime: DateTime(2020, 5, 1, 5),
    destination: "BAT account",
    type: "Received",
  ),
  Transactions(
    amount: 1.98842,
    price: 183.23546,
    code: "BCH",
    dateTime: DateTime(2020, 8, 8, 6),
    destination: "BCH account",
    type: "Sent",
  ),
  Transactions(
    amount: 1.98842,
    price: 183.23546,
    code: "BCH",
    dateTime: DateTime(2020, 8, 8, 14),
    destination: "BCH account",
    type: "Sent",
  ),
  Transactions(
    amount: 80.52842,
    price: 0.25467,
    code: "BAT",
    dateTime: DateTime(2020, 8, 9, 15),
    destination: "BAT account",
    type: "Received",
  ),
  Transactions(
    amount: 80.52842,
    price: 0.25467,
    code: "BAT",
    dateTime: DateTime(2020, 8, 9, 6),
    destination: "BAT account",
    type: "Received",
  ),
  Transactions(
    amount: 15.52842,
    price: 9537.64145,
    code: "BTC",
    dateTime: DateTime(2020, 8, 7, 5),
    destination: "BTC account",
    type: "Withdrew",
  ),
];
