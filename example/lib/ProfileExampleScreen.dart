import 'package:animated_background_view/animated_background_view.dart';
import 'package:flutter/material.dart';

class ProfileExampleScreen extends StatefulWidget {

  const ProfileExampleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileExampleScreenState();

}

class _ProfileExampleScreenState extends State<ProfileExampleScreen>{

  static const collapsedBarHeight = 56.0;
  static const expandedBarHeight = 220.0;
  final ScrollController _controller = ScrollController();
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification){
          final isCollapsed = _controller.hasClients &&
              _controller.offset > (expandedBarHeight - collapsedBarHeight);
          setState(() { _isCollapsed = isCollapsed; });
          return false;
        },
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverAppBar(
              expandedHeight: expandedBarHeight,
              collapsedHeight: collapsedBarHeight,
              floating: true,
              pinned: true,
              backgroundColor: Colors.blue,
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isCollapsed ? 1 : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/219/219983.png',
                        width: 36,
                        height: 36,
                      )
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User Name', style: TextStyle( color: Colors.white, fontSize: 16.0 )),
                          Text('user detail', style: TextStyle( color: Colors.white, fontSize: 12.0 ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const AnimatedBackground(fps: 40, type: BackgroundType.movingGlares, blurAmount: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 32,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                'https://cdn-icons-png.flaticon.com/512/219/219983.png',
                                width: 86,
                                height: 86,
                              )
                            ),
                            const SizedBox(height: 16,),
                            Text('User Name', style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8,),
                            Text('user detail', style: Theme.of(context).textTheme.titleMedium,),
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Material(
                  elevation: 7,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Example of real-life usage'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}