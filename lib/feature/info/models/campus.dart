class Buffet {
  String id;
  String name;
  String workTime;
  String address;
  String createdAt;

  Buffet({
    required this.id,
    required this.name,
    required this.workTime,
    required this.address,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Buffet{ id: $id, name: $name, workTime: $workTime, address: $address, createdAt: $createdAt,}';
  }

  Buffet copyWith({
    String? id,
    String? name,
    String? workTime,
    String? address,
    String? createdAt,
  }) {
    return Buffet(
      id: id ?? this.id,
      name: name ?? this.name,
      workTime: workTime ?? this.workTime,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'workTime': workTime,
      'address': address,
      'createdAt': createdAt,
    };
  }

  factory Buffet.fromJson(Map<String, dynamic> map) {
    return Buffet(
      id: map['id'] as String,
      name: map['name'] as String,
      workTime: map['workTime'] as String,
      address: map['address'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}

class Library {
  final String id;
  final String name;
  final List<LibrarySection> sections;

  const Library({
    required this.id,
    required this.name,
    required this.sections,
  });

  @override
  String toString() {
    return 'Library{ id: $id, name: $name, sections: $sections,}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sections': sections,
    };
  }

  factory Library.fromJson(Map<String, dynamic> map) {
    return Library(
      id: map['id'] as String,
      name: map['name'] as String,
      sections: (map['sections'] as List)
          .map((e) => LibrarySection.fromJson(e))
          .toList(),
    );
  }
}

class LibrarySection {
  final String id;
  final String name;
  final String location;
  final String libraryId;

  const LibrarySection({
    required this.id,
    required this.name,
    required this.location,
    required this.libraryId,
  });

  @override
  String toString() {
    return 'Sections{ id: $id, name: $name, location: $location, libraryId: $libraryId,}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'libraryId': libraryId,
    };
  }

  factory LibrarySection.fromJson(Map<String, dynamic> map) {
    return LibrarySection(
      id: map['id'] as String,
      name: map['name'] as String,
      location: map['location'] as String,
      libraryId: map['libraryId'] as String,
    );
  }
}

