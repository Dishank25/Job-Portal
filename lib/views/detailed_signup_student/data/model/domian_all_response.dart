// class DomainAllResponse {
//   final List<String> domains;

//   DomainAllResponse({required this.domains});

//   factory DomainAllResponse.fromJson(Map<String, dynamic> json) {
//     return DomainAllResponse(
//       domains: List<String>.from(json['domains'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'domains': domains,
//     };
//   }
// }
class DomainAllResponse {
  final List<String> domains;

  DomainAllResponse({required this.domains});

  factory DomainAllResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> domainsData = json['domains'] ?? [];
    final List<String> domainNames = domainsData
        .map((item) =>
            item['name'] as String? ??
            '') // Extract name from each domain object
        .where((name) => name.isNotEmpty) // Filter out empty names
        .toList();

    return DomainAllResponse(
      domains: domainNames, // Now this is List<String>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domains': domains,
    };
  }
}
