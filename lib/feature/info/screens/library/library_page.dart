import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/assets.dart';
import '../../models/campus.dart';
import 'library_page_cubit.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = LibraryPageCubit();
        cubit.loadData();
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Библиотеки',
            style: listItemTitle,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
            color: colorBorder,
            height: 1,
          ),
          ),
        ),
        body: BlocBuilder<LibraryPageCubit, LibraryPageState>(
          builder: (context, state) {
            if (state is LibraryLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is LibraryPageLoadedState) {
              return LibraryLoadedView(
                libraries: state.libraries,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class LibraryLoadedView extends StatelessWidget {
  const LibraryLoadedView({Key? key, required this.libraries})
      : super(key: key);
  final List<Library> libraries;

  @override
  Widget build(BuildContext context) {
    return  ListView(
      padding: EdgeInsets.all(16),
        children: [
          for (var library in libraries) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(library.name, style: headline5,),
              for (var section in library.sections) Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: colorBorder, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(section.name),
                    subtitle: Text(section.location),
                  )
                ],
              )
            ],
          ),
        ],
      );
  }
}
