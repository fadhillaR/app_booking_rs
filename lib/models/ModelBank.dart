class Bank {
  final String name;
  final String logo;
  final String accountNumber;
  final String accountHolder;

  Bank({
    required this.name,
    required this.logo,
    required this.accountNumber,
    required this.accountHolder,
  });
}

final List<Bank> banks = [
  Bank(
    name: 'BRI',
    logo: 'assets/bri.png',
    accountNumber: '1234-5678-9000',
    accountHolder: 'Yayasan Kebaikan',
  ),
  Bank(
    name: 'BNI',
    logo: 'assets/bni.png',
    accountNumber: '9876-5432-1000',
    accountHolder: 'Yayasan Kasih',
  ),
  Bank(
    name: 'Bank Mandiri',
    logo: 'assets/mandiri.png',
    accountNumber: '1122-3344-5566',
    accountHolder: 'Yayasan Amanah',
  ),
  Bank(
    name: 'BSI',
    logo: 'assets/bsi.png',
    accountNumber: '9876-5432-1000',
    accountHolder: 'Yayasan Peduli',
  ),
  Bank(
    name: 'Bank Nagari',
    logo: 'assets/nagari.png',
    accountNumber: '6655-4433-2211',
    accountHolder: 'Yayasan Cinta',
  ),
];
