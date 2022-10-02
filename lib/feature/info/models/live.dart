class Stadium {
  final String id;
  final String name;
  final String address;
  final List<SportSection> sections;

  const Stadium({
    required this.id,
    required this.name,
    required this.address,
    required this.sections,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'sections': sections,
    };
  }

  factory Stadium.fromJson(Map<String, dynamic> map) {
    return Stadium(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      sections: (map['sections'] as List)
          .map((e) => SportSection.fromJson(e))
          .toList(),
    );
  }
}

class SportSection {
  final String id;
  final String name;
  final String contactName;
  final String contact;
  final String corpusId;

  const SportSection({
    required this.id,
    required this.name,
    required this.contactName,
    required this.contact,
    required this.corpusId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactName': contactName,
      'contact': contact,
      'corpusId': corpusId,
    };
  }

  factory SportSection.fromJson(Map<String, dynamic> map) {
    return SportSection(
      id: map['id'] as String,
      name: map['name'] as String,
      contactName: map['contactName'] as String,
      contact: map['contact'] as String,
      corpusId: map['corpusId'] as String,
    );
  }
}

class StudentOrganization {
  final String id;
  final String name;
  final String contact;
  final String address;
  final String createdAt;

  const StudentOrganization({
    required this.id,
    required this.name,
    required this.contact,
    required this.address,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'contact': this.contact,
      'address': this.address,
      'createdAt': this.createdAt,
    };
  }

  factory StudentOrganization.fromJson(Map<String, dynamic> map) {
    return StudentOrganization(
      id: map['id'] as String,
      name: map['name'] as String,
      contact: map['contact'] as String,
      address: map['address'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}

class CreativeOrganizations {
  final String id;
  final String name;
  final String contactName;
  final String contact;
  final String description;
  final String createdAt;

  const CreativeOrganizations({
    required this.id,
    required this.name,
    required this.contactName,
    required this.contact,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'contactName': this.contactName,
      'contact': this.contact,
      'description': this.description,
      'createdAt': this.createdAt,
    };
  }

  factory CreativeOrganizations.fromJson(Map<String, dynamic> map) {
    return CreativeOrganizations(
      id: map['id'] as String,
      name: map['name'] as String,
      contactName: map['contactName'] as String,
      contact: map['contact'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}

// "id": "22267607-fc2e-4a29-bcdd-492b98c05e1c",
// "name": "Студия эстрадного танца Sensuel",
// "contactName": "Наталья Квасильчук",
// "contact": "+7 926 677-96-51",
// "description": "Студия эстрадного танца Sensuel основана в 2007 году. В репертуаре коллектива — номера на основе как классической хореографии, так и современных танцевальных стилей. Коллектив постоянно участвует в концертных программах ДКиТ МАИ, а также в творческих проектах на других площадках Москвы.  Студия хореографии Sensuel всегда рада видеть в своём коллективе новых участников. Благодаря разнообразию репертуара, в коллективе Sensuel каждый найдёт то, что нужно именно ему!",
// "createdAt": "2021-11-27 15:51:35.0"
