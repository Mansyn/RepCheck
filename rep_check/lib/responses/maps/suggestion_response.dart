class SuggestionResponse {
  final String placeId;
  final String description;
  final List<String> types;

  SuggestionResponse(this.placeId, this.description, this.types);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
