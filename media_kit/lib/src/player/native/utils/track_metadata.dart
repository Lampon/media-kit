/// Resolves the user-facing title for a native media track.
///
/// libmpv exposes MP4/MOV handler names under per-track metadata rather than
/// `track-list/N/title`. Keep an explicit title authoritative, and only use
/// that metadata fallback for audio tracks.
String? resolveTrackTitle({
  required String type,
  String? title,
  String? handlerName,
}) {
  final explicit = title?.trim();
  if (explicit != null && explicit.isNotEmpty) return explicit;
  if (type != 'audio') return null;
  final handler = handlerName?.trim();
  return handler == null || handler.isEmpty ? null : handler;
}
