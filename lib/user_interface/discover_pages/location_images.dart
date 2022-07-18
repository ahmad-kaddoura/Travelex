import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

//IMAGE SOURCE : copy image address from pinterest

class LocationImages extends StatelessWidget {
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;
  final String img6;
  final String img7;
  final String img8;
  final String img9;
  final String img10;
  const LocationImages(this.img1, this.img2, this.img3, this.img4, this.img5,
      this.img6, this.img7, this.img8, this.img9, this.img10);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: buildImageCard(0, img1),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: buildImageCard(1, img2),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: buildImageCard(2, img3),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: buildImageCard(3, img4),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 2,
                    child: buildImageCard(4, img5),
                  ),
                ],
              ),
            ),
            //Second set -- 5 -> 10 indexed images
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: buildImageCard(0, img6),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: buildImageCard(1, img7),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: buildImageCard(2, img8),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: buildImageCard(3, img9),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 2,
                    child: buildImageCard(4, img10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageCard(int index, String url) => Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          //margin: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[400],
                highlightColor: Colors.amber,
              ),
              imageBuilder: (context, imageProvider) => Container(
                //height: 27.h,
                //width: 88.w,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(25.0),
                  color: Colors.grey[400],
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    //colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Shimmer.fromColors(
                baseColor: Colors.grey[400],
                highlightColor: Colors.grey[350],
              ),
            ),
          ),
        ),
      );
}
