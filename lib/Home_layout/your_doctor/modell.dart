class Doctor {
  String id;
  String image;
  String name;
  String use;

  String Address;
  String PhoneNumber;
  String Availability;

  String Fee;
  String About;

  Doctor({
    required this.id,
    required this.Address,
    required this.PhoneNumber,
    required this.Availability,
    required this.Fee,
    required this.About,
    required this.image,
    required this.name,
    required this.use,
  });

  static List<Doctor> doctors = [
    Doctor(
        id: '1',
        image: 'assets/images/FDr1.png',
        name: 'Amal Elsayed',
        use: 'Neurologist',
        Address: 'Moharm Beh:Rasafa Street',
        PhoneNumber: '16676',
        Availability: '9AM -5PM',
        Fee: '360 EGP',
        About: 'Wating Time:2 Hours'),
    Doctor(
        id: '2',
        image: 'assets/images/FDr2.png',
        name: 'Amany Nabil',
        use: 'Surgeon',
        Address: 'Moharm Beh:Bwalino',
        PhoneNumber: '03 5831436',
        Availability: '2PM -9PM',
        Fee: '150 EGP',
        About: 'Wating Time:10 Minutees'),
    Doctor(
        id: '3',
        image: 'assets/images/Dr4.png',
        name: 'Mohamoud el sharkawy',
        use: 'Radiologist',
        Address: 'Smouha: Garden City Street,Taaweneyat Sm',
        PhoneNumber: '16676',
        Availability: '3PM -3PM',
        Fee: '200 EGP',
        About: ''),
    Doctor(
        id: '4',
        image: 'assets/images/Dr6.png',
        name: 'Michael Eskandder',
        use: 'Neurologist',
        Address: 'Clieopatra:ibn Grah',
        PhoneNumber: '16675',
        Availability: '12PM -9PM',
        Fee: '100 EGP',
        About: ''),
    Doctor(
        id: '5',
        image: 'assets/images/Dr7.png',
        name: 'Walid Glal elshazly',
        use: 'Surgeon',
        Address: 'Mahta All Raml SQ., Al Attarin',
        PhoneNumber: '03 4808991',
        Availability: '2PM -9PM',
        Fee: '400 EGP',
        About: 'Wating Time:2 Hours'),
    Doctor(
        id: '6',
        image: 'assets/images/Dr4.png',
        name: 'Omar Elgebaly',
        use: 'Immunologist',
        Address: 'Smoha: Vector',
        PhoneNumber: '16673',
        Availability: '10AM -11PM',
        Fee: '300 EGP',
        About: 'Wating Time:19 Minutees'),
    Doctor(
        id: '7',
        image: 'assets/images/FDr3.png',
        name: 'Sahar Kamal',
        use: 'Dermatologist',
        Address: 'Smoha: Fawzy Moaz st',
        PhoneNumber: '16673',
        Availability: '2PM -12AM',
        Fee: '200 EGP',
        About: 'Wating Time:7 Minutees'),
    Doctor(
        id: '8',
        image: 'assets/images/Dr4.png',
        name: 'Hossam Hamd',
        use: 'Dentist',
        Address: 'Sidy Bishr:gamal abdelnaser',
        PhoneNumber: '16699',
        Availability: '2PM -9PM',
        Fee: '300 EGP',
        About: ''),
    Doctor(
        id: '9',
        image: 'assets/images/Dr4.png',
        name: 'Mohamed Shams',
        use: 'Dentist',
        Address: 'El-ibrahimia: Port said',
        PhoneNumber: '15236',
        Availability: '2PM -9PM',
        Fee: '250 EGP',
        About: 'waiting Time:30 Minutes'),
    Doctor(
        id: '10',
        image: 'assets/images/Dr4.png',
        name: 'Hany Shaarawy',
        use: 'Dermatologist',
        Address: 'Cleopatra: Port said',
        PhoneNumber: '14556',
        Availability: '3PM -12AM',
        Fee: '350 EGP',
        About: ''),
  ];

  Doctor findById(String id) {
    return doctors.firstWhere((pdt) => pdt.id == id);
  }
}
