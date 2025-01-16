import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/Colors/colors.dart';
import 'package:untitled2/Dio/dio.dart';
import 'package:untitled2/Provider/news_notifier.dart';
import 'package:untitled2/Provider/theme_notifier.dart';
import 'package:untitled2/model/news_information.dart';
import 'package:untitled2/widget/toast_message.dart';
import '../main.dart';
import '../widget/custom_card.dart';
import 'news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  Country? selectedCountry;
  bool isLoading = false;
  bool isCompleted = false;

  @override
  void didPopNext() {
    Provider.of<NewsNotifier>(context, listen: false).clearNews();
    super.didPopNext();

  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }


  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }



  Future<void> onSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });
      for (var section in Provider.of<NewsNotifier>(context,listen: false).selectedList) {
        List<Articles>? news = await DioHttp().getHttp(section);
        debugPrint('the news itself: $news');

        if (mounted) {
          Provider.of<NewsNotifier>(context, listen: false).allNews.addAll([...?news]);
        }
      }
      debugPrint(
          'All the news : ${Provider.of<NewsNotifier>(context, listen: false).allNews}');

      setState(() {
        isCompleted = true;
      });
      if (isCompleted) {
        debugPrint('$isCompleted');
        if(mounted){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewsScreen()));
        }

        setState(() {
          isLoading = false;
          isCompleted = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 14,
        shadowColor: blackColor,
        forceMaterialTransparency: true,
        title: Text(
          'Daily News',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CupertinoSwitch(
            value: themeNotifier.switchValue,
            activeColor: secondaryColor,
            thumbColor: thumbColor,
            trackColor: trackColor,
            onChanged: (value) {
              themeNotifier.setTheme(value);
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Select Your \nFavorite Section',
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
          Consumer<NewsNotifier>(
            builder: (context, newsNotifier, child){
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 10,
                    childAspectRatio: 8 / 10,
                    scrollDirection: Axis.vertical,
                    children: [
                      CustomCard(
                        icon: const Icon(Icons.health_and_safety),
                        section: 'Health',
                        onSelected: newsNotifier.toggleSelectedSection,
                      ),
                      CustomCard(
                        icon: const Icon(Icons.business_center),
                        section: 'Business',
                        onSelected: newsNotifier.toggleSelectedSection,
                      ),
                      CustomCard(
                        icon: const Icon(Icons.sports_baseball_rounded),
                        section: 'Sports',
                        onSelected: newsNotifier.toggleSelectedSection,
                      ),
                      CustomCard(
                        icon: const Icon(Icons.science),
                        section: 'Science',
                        onSelected: newsNotifier.toggleSelectedSection,
                      ),
                      CustomCard(
                        icon: const Icon(Icons.computer),
                        section: 'Technology',
                        onSelected: newsNotifier.toggleSelectedSection,
                      ),
                      CustomCard(
                        icon: const Icon(Icons.multitrack_audio),
                        section: 'Entertainment',
                        onSelected: newsNotifier.toggleSelectedSection,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (Provider.of<NewsNotifier>(context, listen: false).selectedList.isNotEmpty) {
                onSubmit();
              } else {
                showToast(message: 'Choose at least one section');
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:
                Provider.of<NewsNotifier>(context).selectedList.isEmpty ? Colors.grey : primaryColor,
                foregroundColor: secondaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                elevation: 15.0),
            child: isLoading
                ? SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                    ),
                  )
                : const Text('Get Started'),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10))
        ],
      ),
    );
  }
}
