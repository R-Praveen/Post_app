import 'package:flutter/material.dart';
import 'package:posts_app/blocs/photos_bloc.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/providers/bloc_provider.dart';
import 'package:posts_app/screens/albums.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:provider/provider.dart';

class Photos extends StatelessWidget {
  static const route = '/photos';
  const Photos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as PhotosArgument;
    return Provider(
      create: (BuildContext context) => providePhotosBloc(
        arguments.albumId,
        arguments.title,
      ),
      child: Builder(builder: (context) {
        final bloc = Provider.of<PhotosBloc>(context);
        return Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            backgroundColor: AppColors.tundora,
            title: Text(
              bloc.title,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: StreamBuilder<List<Photo>>(
            stream: bloc.photos,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Column(
                      children: [
                        ...snapshot.data!.map(
                          (photo) {
                            return _PhotoCard(photo: photo);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final Photo photo;
  const _PhotoCard({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.tundora,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        margin: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.03,
        ),
        child: Container(
          color: AppColors.tundora,
          child: Column(
            children: [
              Image.network(
                photo.url,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  photo.title,
                  style: const TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
