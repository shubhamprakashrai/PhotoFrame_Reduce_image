import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: PhotoFrame(
          imageUrl:'https://images.unsplash.com/photo-1715698576283-d6ee92b7157a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8',
          useCache: true,
          // cacheManager: CacheManager(
          //   Config(
          //     'customCacheKey',
          //     stalePeriod: const Duration(days: 1),
          //     maxNrOfCacheObjects: 100,
          //   ),
          // ),
          maxHeightDiskCache: 100,
          maxWidthDiskCache: 100,
          memCacheHeight: 50,
          memCacheWidth: 50,
          borderRadius: 5.0,
          placeholderColor: Colors.grey,
          errorIconColor: Colors.red,
          backgroundColorCircularProgress: Colors.black26,
          alwaysStoppedAnimationColor: Colors.purple,
          heightOfImg: 300,
          widthOfImg: 300,
        ),
      ),
    );
  }
}

class PhotoFrame extends StatelessWidget {
  final String imageUrl;
  final bool useCache;
  final CacheManager? cacheManager;
  final bool doubleInfinityWidth;
  final int maxHeightDiskCache;
  final int maxWidthDiskCache;
  final int memCacheHeight;
  final int memCacheWidth;
  final double borderRadius;
  final Color? placeholderColor;
  final Color? errorIconColor;
  final Color? backgroundColorCircularProgress;
  final Color? alwaysStoppedAnimationColor;
  final double? heightOfSizedBox;
  final double? widthOfSizedBox;
  final double? heightOfImg;
  final double? widthOfImg;
  final double? heightOfImgProgrss;
  final double? widthOfImgProgrss;
  final double? strokeWidthofCircular;
  const PhotoFrame(
      {super.key,
      required this.imageUrl,
      this.useCache = true,
      this.cacheManager,
      this.doubleInfinityWidth = true,
      this.maxHeightDiskCache = 100,
      this.maxWidthDiskCache = 100,
      this.memCacheHeight = 100,
      this.memCacheWidth = 100,
      this.borderRadius = 10.0,
      this.placeholderColor,
      this.errorIconColor,
      this.backgroundColorCircularProgress,
      this.alwaysStoppedAnimationColor,
      this.heightOfSizedBox,
      this.widthOfSizedBox,
      this.heightOfImg,
      this.widthOfImg,
      this.heightOfImgProgrss = 15,
      this.widthOfImgProgrss = 15,
      this.strokeWidthofCircular = 1.6
      });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: widthOfSizedBox,
        height: heightOfSizedBox,
        child: useCache
            ? CachedNetworkImage(
                cacheManager: cacheManager,
                maxHeightDiskCache: maxHeightDiskCache,
                maxWidthDiskCache: maxWidthDiskCache,
                memCacheHeight: memCacheHeight,
                memCacheWidth: memCacheWidth,
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    height: heightOfImgProgrss,
                    width: widthOfImgProgrss,
                    child: CircularProgressIndicator(
                      strokeWidth: strokeWidthofCircular??1.6,
                      backgroundColor:
                          backgroundColorCircularProgress ?? Colors.black26,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        alwaysStoppedAnimationColor ?? Colors.blue,
                      ),
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) {
                  return Image(
                    height: heightOfImg,
                    width: widthOfImg,
                    image: imageProvider,
                    fit: BoxFit.cover,
                  );
                },
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: errorIconColor ?? Colors.red,
                ),
              )
            : Image.network(
                imageUrl,
                height: heightOfImg,
                width: widthOfImg,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      height: heightOfImgProgrss,
                      width: heightOfImgProgrss,
                      child: CircularProgressIndicator(
                        strokeWidth: strokeWidthofCircular??1.6,
                        backgroundColor:
                            backgroundColorCircularProgress ?? Colors.black26,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          alwaysStoppedAnimationColor ?? Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.error,
                  color: errorIconColor ?? Colors.red,
                ),
              ),
      ),
    );
  }
}
