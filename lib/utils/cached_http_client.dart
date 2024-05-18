import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:objectbox/objectbox.dart';
import 'package:vagalivre/objectbox.g.dart';

class CachedHttpClient {
  final Client _client;
  final Store _objBoxStore;

  CachedHttpClient(this._client, this._objBoxStore);

  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    final box = _objBoxStore.box<CachedHttpResponse>();
    final cacheQuery = box.query(CachedHttpResponse_.url.equals(url.toString())).build();

    final cachedResponse = cacheQuery.findUnique();
    if (cachedResponse != null) {
      final cacheExpired =
          cachedResponse.cachedAt.difference(DateTime.timestamp()) > const Duration(days: 2);

      if (cacheExpired) {
        cacheQuery.remove();
      } else {
        log("Cached!");
        return cachedResponse.toResponse();
      }
    }

    final response = await _client.get(url, headers: headers);

    box.putAsync(CachedHttpResponse.fromResponse(response));

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
