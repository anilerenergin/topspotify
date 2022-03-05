// To parse this JSON data, do
//
//     final tracks = tracksFromJson(jsonString);

import 'dart:convert';

Tracks tracksFromJson(String str) => Tracks.fromJson(json.decode(str));

String tracksToJson(Tracks data) => json.encode(data.toJson());

class Tracks {
    Tracks({
        this.items,
        this.total,
        this.limit,
        this.offset,
        this.previous,
        this.href,
        this.next,
    });

    List<Item>? items;
    int? total;
    int? limit;
    int? offset;
    dynamic previous;
    String? href;
    String? next;

    factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"],
        limit: json["limit"],
        offset: json["offset"],
        previous: json["previous"],
        href: json["href"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "total": total,
        "limit": limit,
        "offset": offset,
        "previous": previous,
        "href": href,
        "next": next,
    };
}

class Item {
    Item({
        this.album,
        this.artists,
        this.availableMarkets,
        this.discNumber,
        this.durationMs,
        this.explicit,
        this.externalIds,
        this.externalUrls,
        this.href,
        this.id,
        this.isLocal,
        this.name,
        this.popularity,
        this.previewUrl,
        this.trackNumber,
        this.type,
        this.uri,
    });

    Album? album;
    List<Artist>? artists;
    List<String>? availableMarkets;
    int? discNumber;
    int? durationMs;
    bool? explicit;
    ExternalIds? externalIds;
    ExternalUrls? externalUrls;
    String? href;
    String? id;
    bool? isLocal;
    String? name;
    int? popularity;
    String? previewUrl;
    int? trackNumber;
    String? type;
    String? uri;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        album: Album.fromJson(json["album"]),
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        availableMarkets: List<String>.from(json["available_markets"].map((x) => x)),
        discNumber: json["disc_number"],
        durationMs: json["duration_ms"],
        explicit: json["explicit"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        isLocal: json["is_local"],
        name: json["name"],
        popularity: json["popularity"],
        previewUrl: json["preview_url"],
        trackNumber: json["track_number"],
        type: json["type"],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "album": album!.toJson(),
        "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
        "available_markets": List<dynamic>.from(availableMarkets!.map((x) => x)),
        "disc_number": discNumber,
        "duration_ms": durationMs,
        "explicit": explicit,
        "external_ids": externalIds!.toJson(),
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "is_local": isLocal,
        "name": name,
        "popularity": popularity,
        "preview_url": previewUrl,
        "track_number": trackNumber,
        "type": type,
        "uri": uri,
    };
}

class Album {
    Album({
        this.albumType,
        this.artists,
        this.availableMarkets,
        this.externalUrls,
        this.href,
        this.id,
        this.images,
        this.name,
        this.releaseDate,
        this.releaseDatePrecision,
        this.totalTracks,
        this.type,
        this.uri,
    });

    String? albumType;
    List<Artist>? artists;
    List<String>? availableMarkets;
    ExternalUrls? externalUrls;
    String? href;
    String? id;
    List<Images>? images;
    String? name;
    DateTime? releaseDate;
    String? releaseDatePrecision;
    int? totalTracks;
    String? type;
    String? uri;

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumType: json["album_type"],
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        availableMarkets: List<String>.from(json["available_markets"].map((x) => x)),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        name: json["name"],
  
        releaseDatePrecision: json["release_date_precision"],
        totalTracks: json["total_tracks"],
        type: json["type"],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "album_type": albumType,
        "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
        "available_markets": List<dynamic>.from(availableMarkets!.map((x) => x)),
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "name": name,
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "release_date_precision": releaseDatePrecision,
        "total_tracks": totalTracks,
        "type": type,
        "uri": uri,
    };
}

class Artist {
    Artist({
        this.externalUrls,
        this.href,
        this.id,
        this.name,
        this.type,
        this.uri,
    });

    ExternalUrls? externalUrls;
    String? href;
    String? id;
    String? name;
    String? type;
    String? uri;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: json["type"],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "name": name,
        "type": type,
        "uri": uri,
    };
}

class ExternalUrls {
    ExternalUrls({
        this.spotify,
    });

    String? spotify;

    factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
    );

    Map<String, dynamic> toJson() => {
        "spotify": spotify,
    };
}

class Images {
    Images({
        this.height,
        this.url,
        this.width,
    });

    int? height;
    String? url;
    int? width;

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
    };
}

class ExternalIds {
    ExternalIds({
        this.isrc,
    });

    String? isrc;

    factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        isrc: json["isrc"],
    );

    Map<String, dynamic> toJson() => {
        "isrc": isrc,
    };
}
