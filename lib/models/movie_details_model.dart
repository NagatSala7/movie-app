import 'package:hive/hive.dart';

class MovieDetailsModel {
  final int id;
  final String title;
  final String? backdropPath;
  final String? posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int runtime;
  final List<GenreModel> genres;

  MovieDetailsModel({
    required this.id,
    required this.title,
    this.backdropPath,
    this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((genre) => GenreModel.fromJson(genre))
          .toList(),
    );
  }
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
class MovieDetailsModelAdapter extends TypeAdapter<MovieDetailsModel> {
  @override
  final int typeId = 0;

  @override
  MovieDetailsModel read(BinaryReader reader) {
    return MovieDetailsModel(
      id: reader.readInt(),
      title: reader.readString(),
      backdropPath: reader.read(),
      posterPath: reader.read(),
      overview: reader.readString(),
      releaseDate: reader.readString(),
      voteAverage: reader.readDouble(),
      runtime: reader.readInt(),
      genres: (reader.read() as List).cast<GenreModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailsModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.write(obj.backdropPath);
    writer.write(obj.posterPath);
    writer.writeString(obj.overview);
    writer.writeString(obj.releaseDate);
    writer.writeDouble(obj.voteAverage);
    writer.writeInt(obj.runtime);
    writer.write(obj.genres);
  }
}

class GenreModelAdapter extends TypeAdapter<GenreModel> {
  @override
  final int typeId = 1;

  @override
  GenreModel read(BinaryReader reader) {
    return GenreModel(
      id: reader.readInt(),
      name: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, GenreModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
  }
}