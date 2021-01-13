class Notifications {
  String title;
  String subtitle;
  String image;

  Notifications({this.image, this.subtitle, this.title});
}

List<Notifications> notifications = [
  Notifications(
    title: "First Notification",
    subtitle: "Pending payment",
    image: 'assets/icons/sell_crypto.png',
  ),
  Notifications(
    title: "Second Notification",
    subtitle: "Received payment from David",
    image: 'assets/icons/bank.png',
  ),
  Notifications(
    title: "Third Notification",
    subtitle: "The invoice of the month is ready",
    image: 'assets/icons/policy.png',
  ),
  Notifications(
    title: "Fourth Notification",
    subtitle: "Missed payment",
    image: 'assets/icons/terms.png',
  ),
];
