class Country {
  final String name;
  final String officialName;
  final String tld;
  final String cca2;
  final String cca3;
  final String cioc;

  Country({
    required this.name,
    required this.officialName,
    required this.tld,
    required this.cca2,
    required this.cca3,
    required this.cioc,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? '',
      officialName: json['name']['official'] ?? '',
      tld: (json['tld'] as List).isNotEmpty ? json['tld'][0] : '',
      cca2: json['cca2'] ?? '',
      cca3: json['cca3'] ?? '',
      cioc: json['cioc'] ?? '',
    );
  }
}
