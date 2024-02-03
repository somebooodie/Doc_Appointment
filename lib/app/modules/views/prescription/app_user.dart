class AppUser {
  final String id;
  final String name;

  AppUser({required this.id, required this.name});

  factory AppUser.fromFirestore(Map<String, dynamic> doc, String id) {
    return AppUser(
      id: id,
      name: doc['name'], // Adjust based on your Firestore structure
    );
  }
}
