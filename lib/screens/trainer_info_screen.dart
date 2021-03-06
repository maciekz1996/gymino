import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import '../models/trainer.dart';
import '../widgets/keyword.dart';
import '../providers/trainers_provider.dart';
import '../size_config.dart';
import '../widgets/custom_title.dart';

class TrainerInfoScreen extends StatefulWidget {
  static const routeName = '/trainerInfo';

  @override
  _TrainerInfoScreenState createState() => _TrainerInfoScreenState();
}

class _TrainerInfoScreenState extends State<TrainerInfoScreen> {
  Trainer _trainer;
  List<dynamic> _supplements = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final trainersProvider = Provider.of<TrainersProvider>(context, listen: false);
    _trainer = ModalRoute.of(context).settings.arguments as Trainer;

    if (_trainer != null) {
      _supplements = trainersProvider.findById(_trainer.id).supplements;
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          header(context, _trainer),
          infoPage(),
        ],
      ),
    );
  }

  Widget infoPage() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.all(0.0),
          itemCount: _supplements.length == 0 ? _supplements.length + 1 : _supplements.length + 2,
          itemBuilder: (context, index) {
            bool last = _supplements.length == index - 1;
            if (index == 0) {
              return infoGrid([
                _trainer.age.toString(),
                '${_trainer.height} cm',
                '${_trainer.weight} kg',
                '${_trainer.trainingTime} lat',
              ], [
                'Wiek',
                'Wzrost',
                'Waga',
                'Staż'
              ]);
            } else if (index == 1) {
              return CustomTitle('Suplementacja');
            } else {
              return supplementItem(
                _supplements[index - 2]['name'],
                _supplements[index - 2]['amount'],
                _supplements[index - 2]['portionsPerDay'],
                _supplements[index - 2]['form'],
                _supplements[index - 2]['unit'],
                last,
              );
            }
          },
        ),
      ),
    );
  }

  Widget header(context, Trainer trainer) {
    final _appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(trainer.image),
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Stack(
        children: <Widget>[
          _appBar,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    trainer.name,
                    style: Theme.of(context).textTheme.display2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      _trainer.calisthenics ? Keyword('Kalistenika', false) : Container(),
                      _trainer.gym ? Keyword('Siłownia', false) : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget supplementItem(String name, int amount, int portionsPerDay, int form, int unit, bool isLast) {
    String displayUnit = '';
    if (unit == 1) {
      displayUnit = 'ug';
    } else if (unit == 2) {
      displayUnit = 'mg';
    } else {
      displayUnit = 'g';
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      constraints: BoxConstraints(minHeight: 130),
      margin: isLast
          ? EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 5.0,
              bottom: MediaQuery.of(context).padding.bottom + 5.0,
            )
          : const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Global().mediumGrey,
        image: DecorationImage(
          image: form == 1 ? AssetImage('assets/images/supplements/powder.jpeg') : AssetImage('assets/images/supplements/pills.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black38,
            BlendMode.darken,
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              name,
              style: Theme.of(context).textTheme.display2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 3),
            Text(
              '$amount $displayUnit x $portionsPerDay dziennie',
              style: Theme.of(context).textTheme.body1.copyWith(
                    color: Global().canvasColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoGrid(titles, data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTitle('Informacje'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            infoGridTile(context, titles[0], data[0]),
            infoGridTile(context, titles[1], data[1]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            infoGridTile(context, titles[2], data[2]),
            infoGridTile(context, titles[3], data[3]),
          ],
        ),
      ],
    );
  }

  Widget infoGridTile(BuildContext context, String title, String subtitle) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.3,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Global().lightGrey,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.body1.copyWith(
                      color: Global().mediumGrey,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
