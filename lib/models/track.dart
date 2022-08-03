class Track {
  String? trackId;
  String? trackName;
  String? albumName;
  String? artistName;
  bool? isExplicit;
  int? rating;

  Track(
      {this.rating,
      this.albumName,
      this.trackId,
      this.isExplicit,
      this.trackName,
      this.artistName});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      trackId: json['track']['track_id'].toString(),
      trackName: json['track']['track_name'],
      albumName: json['track']['album_name'],
      artistName: json['track']['artist_name'],
      isExplicit: json['track']['explicit'] == 0 ? false : true,
      rating: json['track']['track_rating'],
    );
  }
}
