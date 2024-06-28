class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Mengenal Rumah Singgah',
    image: 'assets/b1.png',
    discription: "Selamat datang di aplikasi Rumah Singgah! Rumah Singgah adalah tempat sementara bagi pasien dan keluarga selama menjalani perawatan medis jauh dari rumah"
  ),
  UnbordingContent(
    title: 'Fasilitas dan Layanan',
    image: 'assets/b2.png',
    discription: "Temukan informasi lengkap tentang fasilitas yang kami sediakan, seperti kamar tidur, dapur, dan ruang santai."
  ),
  UnbordingContent(
    title: 'Cara Membooking Rumah Singgah',
    image: 'assets/b3.png',
    discription: "Booking rumah singgah terdekat dengan fasilitas medis yang dituju dengan mudah dan cepat."
  ),
];