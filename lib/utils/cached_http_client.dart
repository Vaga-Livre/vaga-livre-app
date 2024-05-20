import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:vagalivre/objectbox.g.dart';

class CachedHttpClient {
  final Client _client;
  final Store _objBoxStore;

  CachedHttpClient(this._client, this._objBoxStore);

  Future<Response> get(Uri uri, {Map<String, String> headers = const {}}) async {
    return send(Request("GET", uri)..headers.addAll(headers), true);
  }

  Future<Response> post(Uri uri, {Map<String, String> headers = const {}, Object? body}) async {
    final request = Request("POST", uri);

    request.headers.addAll(headers);

    switch (body) {
      case List():
        request.bodyBytes = body as List<int>;
      case Map():
        request.bodyBytes = utf8.encode(jsonEncode(body));
        request.headers.putIfAbsent('content-type', () => 'application/json');
      case String():
        request.body = body;
    }

    return send(request, true);
  }

  Future<Response> send(BaseRequest request, bool useCache) async {
    final box = _objBoxStore.box<CachedHttpResponse>();
    final cacheQuery = box.query(CachedHttpResponse_.url.equals(request.url.toString())).build();

    final cachedResponse = cacheQuery.findUnique();
    if (cachedResponse != null) {
      final cacheExpired =
          cachedResponse.cachedAt.difference(DateTime.timestamp()) > const Duration(days: 2);

      if (cacheExpired) {
        cacheQuery.remove();
      } else {
        if (useCache) return cachedResponse.toResponse();
      }
    }

    final responseStream = await _client.send(request);
    final response = await Response.fromStream(responseStream);

    if (useCache) box.putAsync(CachedHttpResponse.fromResponse(response));

    return response;
  }
}

@Entity()
class CachedHttpResponse {
  @Id()
  int id;

  @Index()
  @Unique(onConflict: ConflictStrategy.replace)
  final String url;

  final Uint8List responseBytes;

  final int statusCode;
  final String headersJson;
  final bool isRedirect;
  final String? reasonPhrase;

  // Time with millisecond precision restored in UTC time zone.
  @Transient()
  final DateTime cachedAt;

  int get dbUtcDate => cachedAt.millisecondsSinceEpoch;

  CachedHttpResponse(
    this.id,
    this.url,
    this.responseBytes,
    this.statusCode,
    this.headersJson,
    this.isRedirect,
    this.reasonPhrase,
    int dbUtcDate,
  ) : cachedAt = DateTime.fromMillisecondsSinceEpoch(dbUtcDate);

  factory CachedHttpResponse.fromResponse(Response response) {
    return CachedHttpResponse(
      0,
      response.request!.url.toString(),
      response.bodyBytes,
      response.statusCode,
      json.encode(response.headers),
      response.isRedirect,
      response.reasonPhrase,
      DateTime.timestamp().millisecondsSinceEpoch,
    );
  }

  Response toResponse() {
    return Response.bytes(
      responseBytes,
      statusCode,
      headers: json.decode(headersJson).cast<String, String>(),
      reasonPhrase: reasonPhrase,
      isRedirect: isRedirect,
    );
  }
}
