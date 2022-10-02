import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../../../assets/assets.dart';

class CampusSchemePage extends StatelessWidget {
  const CampusSchemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = Image.asset('assets/map.png');
    // showImageViewer(context, imageProvider.image);
    return Scaffold(
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
          'Схема кампуса',
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
      body: Container(
        color: Colors.white,
        child: EasyImageView(
          imageProvider: imageProvider.image,
        ),
      ),
    );
  }
}
