extension LastActiveExtension on String {
  String get lastActiveText {
    try {
      final lastActive = DateTime.parse(this).toLocal();
      final now = DateTime.now();
      final diff = now.difference(lastActive);

      if (diff.inMinutes <= 1) {
        return 'Online';
      } else if (diff.inMinutes < 60) {
        return 'Active ${diff.inMinutes} mins ago';
      } else if (diff.inHours < 24) {
        return 'Active ${diff.inHours} hours ago';
      } else if (diff.inDays == 1) {
        return 'Active yesterday';
      } else {
        return 'Active ${diff.inDays} days ago';
      }
    } catch (_) {
      return '';
    }
  }
}
