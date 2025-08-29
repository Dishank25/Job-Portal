class DomainAllResponse {
  final List<String> domains;

  DomainAllResponse({required this.domains});

  factory DomainAllResponse.fromJson(Map<String, dynamic> json) {
    return DomainAllResponse(
      domains: List<String>.from(json['domains'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domains': domains,
    };
  }
}
