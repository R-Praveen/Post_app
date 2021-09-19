import 'package:flutter/material.dart';
import 'package:posts_app/blocs/albums_bloc.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/screens/photos.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:posts_app/theme/text_styles.dart';
import 'package:provider/provider.dart';

class Albums extends StatefulWidget {
  const Albums({Key? key}) : super(key: key);

  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  AlbumsBloc? _bloc;
  @override
  void didChangeDependencies() {
    _bloc ??= Provider.of<AlbumsBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _getHeader(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              StreamBuilder<List<Album>>(
                stream: _bloc!.userAlbums,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final albums = snapshot.data as List<Album>;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...albums.map(
                            (album) {
                              return _AlbumCard(album: album);
                            },
                          ).toList(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }

  Widget _getHeader() {
    return Container(
      color: AppColors.tundora,
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        top: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Text(
        "Albums",
        style: TextStyles.textFieldTitle().copyWith(fontSize: 22),
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final Album album;
  const _AlbumCard({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Photos.route,
              arguments: PhotosArgument(
                title: album.title,
                albumId: album.id,
              ),
            );
          },
          child: Card(
            color: AppColors.tundora,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            margin: EdgeInsets.all(
              MediaQuery.of(context).size.width * 0.03,
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      album.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhotosArgument {
  String albumId;
  String title;
  PhotosArgument({required this.albumId, required this.title});
}
