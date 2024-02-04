class Hospitals {
  static final List<String> governances = [
    'Al Ahmadi', 'Al Asimah', 'Al Farwaniyah', 'Al Jahra', 'Hawalli', 'Mubarak Al-Kabeer'
  ];

  static final Map<String, List<String>> hospitalsByGovernance = {
    'Al Ahmadi': ['Adan Hospital', 'Al Ahmadi Hospital', 'The New Al Ahmadi Hospital', 'Fahaheel Al-Dawhah Hospital', 'Al-Sabah Specialty Medical Center'],
    'Al Asimah': ['Amiri Hospital', 'Mubarak Al-Kabeer Hospital', 'Al-Sabah Hospital', 'Ibn Sina Hospital', 'Al-Razi Hospital'],
    'Al Farwaniyah': ['Farwaniya Hospital', 'Al-Jahra Hospital', 'Sabah Al-Nasser Medical Center', 'Al-Farwaniyah Maternity Hospital', 'Kuwait Center for Mental Health'],
    'Al Jahra': ['Jahra Hospital', 'New Jahra Medical City', 'Tertiary Care Center', 'Al-Tal Medical Clinic', 'Saad Al Abdullah Health Center'],
    'Hawalli': ['Mowasat Hospital', 'Royale Hayat Hospital', 'Dar Al Shifa Hospital', 'Hawalli Pediatric Hospital', 'Al-Salam International Hospital'],
    'Mubarak Al-Kabeer': ['Adan Hospital', 'Mubarak Al-Kabeer Hospital', 'Jabriya Dermatology Hospital', 'The New Mubarak Al-Kabeer Hospital', 'Hadi Clinic'],
  };

  static List<String> getGovernances() {
    return governances;
  }

  static List<String> getHospitalsForGovernance(String governance) {
    return hospitalsByGovernance[governance] ?? [];
  }
}
