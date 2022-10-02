import 'package:flutter/material.dart';
import 'package:mai/feature/info/screens/buffet/buffet_page.dart';
import 'package:mai/feature/info/screens/creative_organizations/creative_page.dart';
import 'package:mai/feature/info/screens/library/library_page.dart';
import 'package:mai/feature/info/screens/map/campus_scheme_page.dart';
import 'package:mai/feature/info/screens/sport/sport_page.dart';
import 'package:mai/feature/info/screens/student_organizations/organization_page.dart';

import '../../../assets/assets.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: false,
        // backgroundColor: Colors.white,
        // elevation: 0,
        title: const Text(
          'Инфо',
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
      body: Padding(
        padding: const EdgeInsets.all( 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Кампус',
              style: headline5,
            ),
            InfoItem(
              icon: const Icon(Icons.map_outlined),
              titleText: 'Схема кампуса',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CampusSchemePage()));
              },
            ),
            InfoItem(
              icon: const Icon(Icons.coffee_outlined),
              titleText: 'Столовые и буффеты',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => BuffetPage()));
              },
            ),
            InfoItem(
              icon: const Icon(Icons.book_outlined),
              titleText: 'Библиотеки',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => LibraryPage()));
              },
            ),
            SizedBox(height: 8,),

            const Text(
              'Жизнь',
              style: headline5,
            ),
            InfoItem(
              icon: const Icon(Icons.sports),
              titleText: 'Спортивные секции',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SportPage()));
              },
            ),
            InfoItem(
              icon: const Icon(Icons.people),
              titleText: 'Студенчиские организации',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => OrganizationsPage()));
              },
            ),
            InfoItem(
              icon: const Icon(Icons.palette),
              titleText: 'Творческие организации',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => CreativeOrganizationsPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key? key,
    required this.icon,
    required this.titleText,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final String titleText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: colorBorder, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          leading: icon,
          title: Text(
            titleText,
            style: listItemTitle,
          ),
        ),
      ),
    );
  }
}
