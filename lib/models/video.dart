class Video {
  final String? id;
  final String? title;
  final String? thumb;
  final String? channel;
  final String? nPage;

  Video({this.id, this.title, this.thumb, this.channel, this.nPage});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id"))
      return Video(
          id: json["id"]["videoId"],
          title: json["snippet"]["title"],
          thumb: json["snippet"]["thumbnails"]["high"]["url"],
          channel: json["snippet"]["channelTitle"],
          nPage: json["nextPageToken"]);
    else
      return Video(
        id: json["id"],
        title: json["title"],
        thumb: json["thumb"],
        channel: json["channel"],
      );
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": id,
      "title": title,
      "thumb": thumb,
      "channel": channel,
    };
  }
}
