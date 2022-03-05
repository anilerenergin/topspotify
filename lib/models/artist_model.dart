// To parse this JSON data, do
//
//     final artists = artistsFromJson(jsonString);

import 'dart:convert';

Artists artistsFromJson(String str) => Artists.fromJson(json.decode(str));

String artistsToJson(Artists data) => json.encode(data.toJson());

class Artists {
    Artists({
        this.items,
        this.total,
        this.limit,
        this.offset,
        this.previous,
        this.href,
        this.next,
    });

    List<ArtistItem>? items;
    int? total;
    int? limit;
    int? offset;
    dynamic previous;
    String? href;
    String? next;

    factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        items: List<ArtistItem>.from(json["items"].map((x) => ArtistItem.fromJson(x))),
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

class ArtistItem {
    ArtistItem({
        this.externalUrls,
        this.followers,
        this.genres,
        this.href,
        this.id,
        this.images,
        this.name,
        this.popularity,
        this.type,
        this.uri,
    });

    ExternalUrls? externalUrls;
    Followers? followers;
    List<String>? genres;
    String? href;
    String? id;
    List<Images>? images;
    String? name;
    int? popularity;
    String? type;
    String? uri;

    factory ArtistItem.fromJson(Map<String, dynamic> json) => ArtistItem(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        followers: Followers.fromJson(json["followers"]),
        genres: List<String>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        name: json["name"],
        popularity: json["popularity"],
        type: json["type"],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "external_urls": externalUrls!.toJson(),
        "followers": followers!.toJson(),
        "genres": List<dynamic>.from(genres!.map((x) => x)),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "name": name,
        "popularity": popularity,
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

class Followers {
    Followers({
        this.href,
        this.total,
    });

    dynamic href;
    int? total;

    factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        href: json["href"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "total": total,
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
