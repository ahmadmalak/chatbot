import 'package:ask_pdf/core/config.dart';
import 'package:ask_pdf/services/langchain_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query_notifier.g.dart';

enum QueryEnum {
  initial,
  loading,
  loaded,
  error,
}

class QueryState {
  final String result;
  final QueryEnum state;
  final List<String> resultList;
  final bool isTyping;

  QueryState({
    required this.result,
    required this.state,
    required this.isTyping,
    this.resultList = const [],
  });

  QueryState copyWith({
    String? result,
    QueryEnum? state,
    List<String>? resultList,
    bool? isTyping,
  }) {
    return QueryState(
      result: result ?? this.result,
      state: state ?? this.state,
      isTyping: isTyping ?? this.isTyping,
      resultList: resultList ?? this.resultList,
    );
  }
}

@riverpod
class QueryNotifier extends _$QueryNotifier {
  @override
  QueryState build() => QueryState(
        result: '',
        state: QueryEnum.initial,
        resultList: [],
        isTyping: false,
      );

  void queryPineConeIndex(String query) async {
    state = QueryState(
      result: '',
      state: QueryEnum.loading,
      resultList: [],
      isTyping: true,
    );

    try {
      final result =
          await ref.read(langchainServiceProvider).queryPineConeVectorStore(
                ServiceConfig.indexName,
                query,
              );
      state = QueryState(
        result: result,
        state: QueryEnum.loaded,
        resultList: [result],
        isTyping: false,
      );
    } catch (e) {
      state = QueryState(
        result: '',
        state: QueryEnum.error,
        resultList: [],
        isTyping: false,
      );
    }
  }
}
