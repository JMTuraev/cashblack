import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/medium_title_widget.dart';
import 'business_details_view.dart';

class BusinessListView extends StatelessWidget {
  const BusinessListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(
              child: MediumTitleWidget(text: 'Categoriya'),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                  );
                },
                itemBuilder: (context, index) {
                  // return _BrandCardWidget();
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => BusinessDetailsView(),
                        ),
                      );
                    },
                    title: Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          height: 100,
                          child: Placeholder(),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const _SimpleTextWidget(
                              title: 'Brand name',
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: const [
                                Icon(
                                  CupertinoIcons.money_dollar_circle,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text('0.3'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _SimpleTextWidget extends StatelessWidget {
  const _SimpleTextWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
