import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_service.g.dart';

@riverpod
AIService aiService(AiServiceRef ref) {
  // TODO: Securely provide the API Key (e.g., from .env or Config)
  const apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  return AIService(apiKey: apiKey);
}

class AIService {
  final String apiKey;
  late final GenerativeModel _model;

  AIService({required this.apiKey}) {
    _model = GenerativeModel(model: 'gemini-flash-latest', apiKey: apiKey);
  }

  /// Analyzes a Resume against a Job Description and Company context.
  /// Returns a JSON string that can be parsed into an AnalysisModel.
  Future<String> analyzeResume({
    required String resumeContent,
    required String jobDescription,
    required String companyContext,
  }) async {
    final prompt =
        '''
    You are an expert technical recruiter and career coach.
    Analyze the following resume against the job description and company context provided.
    
    Resume:
    $resumeContent
    
    Job Description:
    $jobDescription
    
    Company Context:
    $companyContext
    
    Provide your analysis in RAW JSON format with the following keys:
    - readinessScore: (0-100 number)
    - matchLabel: (e.g., "Excellent Match", "Good Potential", etc.)
    - strengths: [List of matching skills/experiences]
    - skillGaps: [List of skills/experiences missing or weak]
    - roadmap: [List of concrete steps for preparation]
    - interviewQuestions: [List of 5-10 personalized interview questions based on gaps]
    - focusAreas: [List of 3 main topics to prioritize]

    Strictly return ONLY the JSON object. Do not include any markdown formatting like ```json.
    ''';

    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? '{}';
  }

  /// Generates a mock interview response/question based on context.
  Future<String> getInterviewResponse({
    required List<Map<String, String>> chatHistory,
    required String jobContext,
  }) async {
    final history = chatHistory.map((m) {
      if (m['role'] == 'user') return Content.text('Candidate: ${m['text']}');
      return Content.text('Interviewer: ${m['text']}');
    }).toList();

    final prompt =
        '''
    You are an interviewer from a top-tier tech company.
    Conduct a mock interview for the following role/context: $jobContext
    
    Current Chat History:
    ${chatHistory.map((m) => '${m['role']}: ${m['text']}').join('\n')}
    
    Provide the next follow-up question or feedback. Be professional and challenging.
    Keep the response concise (max 3-4 sentences).
    ''';

    final response = await _model.generateContent([
      ...history,
      Content.text(prompt),
    ]);

    return response.text ?? '';
  }

  /// Generates a sample interview-ready answer for a given question.
  Future<String> generateQuestionAnswer({
    required String question,
    required String roleContext,
  }) async {
    final prompt =
        '''
    You are an expert interview coach.
    Generate a high-quality sample answer for the interview question below.

    Role Context:
    $roleContext

    Question:
    $question

    Rules:
    - Keep answer concise and practical (120-220 words).
    - For technical questions, structure as:
      1) Approach
      2) Trade-offs
      3) Example
    - For behavioral questions, structure as STAR (Situation, Task, Action, Result).
    - Use clear language suitable for spoken interview response.
    - Return plain text only (no markdown, no bullets with symbols).
    ''';

    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? '';
  }
}
