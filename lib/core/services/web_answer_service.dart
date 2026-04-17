import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final webAnswerServiceProvider = Provider((ref) => WebAnswerService());

class WebAnswerService {
  Future<String> fetchAnswer(String question) async {
    // Try StackOverflow first (more reliable for technical questions)
    final fromStackOverflow = await _fetchFromStackOverflow(question);
    if (fromStackOverflow.isNotEmpty) {
      developer.log('WebAnswer: Found StackOverflow answer for: ${question.substring(0, 50)}...');
      return fromStackOverflow;
    }

    // Fallback to DuckDuckGo
    final fromDuckDuckGo = await _fetchFromDuckDuckGo(question);
    if (fromDuckDuckGo.isNotEmpty) {
      developer.log('WebAnswer: Found DuckDuckGo answer for: ${question.substring(0, 50)}...');
      return fromDuckDuckGo;
    }

    developer.log('WebAnswer: No web answer found for: ${question.substring(0, 50)}...');
    return '';
  }

  Future<String> _fetchFromStackOverflow(String question) async {
    try {
      final searchUri = Uri.https('api.stackexchange.com', '/2.3/search/advanced', {
        'order': 'desc',
        'sort': 'relevance',
        'q': question,
        'site': 'stackoverflow',
        'pagesize': '5',
      });

      final searchResponse = await http.get(searchUri).timeout(
            const Duration(seconds: 10),
          );
      if (searchResponse.statusCode != 200) {
        developer.log('StackOverflow API returned ${searchResponse.statusCode}');
        return '';
      }

      final searchJson = jsonDecode(searchResponse.body) as Map<String, dynamic>;
      final items = (searchJson['items'] as List?) ?? const [];
      if (items.isEmpty) return '';

      final questionIds = items
          .map((item) => item is Map<String, dynamic> ? item['question_id'] : null)
          .whereType<int>()
          .take(3)
          .toList();
      if (questionIds.isEmpty) return '';

      final answersUri = Uri.https(
        'api.stackexchange.com',
        '/2.3/questions/${questionIds.join(';')}/answers',
        {
          'order': 'desc',
          'sort': 'votes',
          'site': 'stackoverflow',
          'filter': 'withbody',
          'pagesize': '5',
        },
      );

      final answersResponse = await http.get(answersUri).timeout(
            const Duration(seconds: 10),
          );
      if (answersResponse.statusCode != 200) return '';

      final answersJson = jsonDecode(answersResponse.body) as Map<String, dynamic>;
      final answers = (answersJson['items'] as List?) ?? const [];
      if (answers.isEmpty) return '';

      // Prefer accepted answer, otherwise use highest voted
      Map<String, dynamic>? selected;
      for (final item in answers) {
        if (item is Map<String, dynamic> && item['is_accepted'] == true) {
          selected = item;
          break;
        }
      }
      selected ??= answers.firstWhere(
        (item) => item is Map<String, dynamic> && (item['score'] as int? ?? 0) > 0,
        orElse: () => answers.isNotEmpty ? answers.first : null,
      );
      if (selected == null) return '';

      final body = (selected['body'] as String?)?.trim() ?? '';
      if (body.isEmpty) return '';

      final score = selected['score'] as int? ?? 0;
      developer.log('StackOverflow answer found with score: $score');
      return _cleanHtml(body);
    } catch (e) {
      developer.log('StackOverflow fetch error: $e');
      return '';
    }
  }

  Future<String> _fetchFromDuckDuckGo(String question) async {
    try {
      final uri = Uri.https('api.duckduckgo.com', '/', {
        'q': question,
        'format': 'json',
        'no_html': '1',
        'skip_disambig': '1',
      });
      final response = await http.get(uri).timeout(
            const Duration(seconds: 10),
          );
      if (response.statusCode != 200) return '';

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final abstractText = (data['AbstractText'] as String?)?.trim() ?? '';
      if (abstractText.isNotEmpty) return abstractText;

      final related = (data['RelatedTopics'] as List?) ?? const [];
      for (final item in related) {
        if (item is Map<String, dynamic>) {
          final text = (item['Text'] as String?)?.trim() ?? '';
          if (text.isNotEmpty) return text;
        }
      }

      return '';
    } catch (e) {
      developer.log('DuckDuckGo fetch error: $e');
      return '';
    }
  }

  String _cleanHtml(String html) {
    var text = html
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ');

    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (text.length > 1100) {
      text = '${text.substring(0, 1100)}...';
    }
    return text;
  }
}
