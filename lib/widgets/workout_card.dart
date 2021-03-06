import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../globals.dart';
import '../widgets/badge.dart';
import '../models/workout.dart';
import '../screens/workout_overview_screen.dart';
import '../widgets/difficulty_level.dart';

class WorkoutCard extends StatelessWidget {
  final bool isFullSize;
  final Workout workout;

  WorkoutCard(
    this.workout,
    this.isFullSize,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(WorkoutOverviewScreen.routeName, arguments: workout.id);
      },
      child: CachedNetworkImage(
        imageUrl: workout.imageUrl,
        placeholder: (context, url) => Center(
          child: Icon(
            Icons.image,
            color: Global().darkGrey,
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.broken_image,
            color: Global().darkGrey,
          ),
        ),
        imageBuilder: (context, imageProvider) => Container(
          width: isFullSize ? double.infinity : MediaQuery.of(context).size.width * 0.5,
          height: isFullSize ? MediaQuery.of(context).size.height * 0.2 : double.infinity,
          constraints: BoxConstraints(minHeight: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Global().mediumGrey,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        workout.name,
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Global().canvasColor,
                              fontWeight: FontWeight.w500,
                              fontSize: isFullSize ? 20 : 17,
                            ),
                        maxLines: isFullSize ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.0),
                      DifficultyLevel(workout.difficulty),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Badge(
                    text: '${workout.duration} min',
                    icon: Icons.access_time,
                    withIcon: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
