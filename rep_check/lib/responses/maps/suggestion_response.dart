class SuggestionResponse {
  final String placeId;
  final String description;

  SuggestionResponse(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
