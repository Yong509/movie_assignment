import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_assignment/widgets/movie/fallback_backdrop_image.dart';

class MovieBackdropCarousel extends StatefulWidget {
  const MovieBackdropCarousel({super.key, required this.imageUrl});

  final List<String> imageUrl;

  @override
  State<MovieBackdropCarousel> createState() => _MovieBackdropCarouselState();
}

class _MovieBackdropCarouselState extends State<MovieBackdropCarousel> {
  final PageController _carouselController = PageController(initialPage: 0);
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _carouselController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: deviceSize.width,
          height: 230,
          child: PageView.builder(
            controller: _carouselController,
            onPageChanged: (index) {
              setState(() {
                _activeIndex = index;
              });
            },
            itemCount: widget.imageUrl.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                key: ValueKey(widget.imageUrl[index]),
                imageUrl: widget.imageUrl[index],
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                errorWidget: (context, url, error) {
                  return const FallbackBackdropImage();
                },
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imageUrl.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () {
                      _carouselController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                    },
                    child: CircleAvatar(
                      key: ValueKey("carousel_indicator_$index"),
                      radius: 4,
                      backgroundColor: _activeIndex == index ? Colors.white : Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade400.withOpacity(0.5),
              ),
              child: const Center(
                child: Icon(Icons.chevron_left),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
