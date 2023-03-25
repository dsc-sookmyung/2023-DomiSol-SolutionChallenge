// 메인페이지 통계 탭바 위젯

import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';

Widget segementedtab(context) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 0.9,
    height: 30,
    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
    child: SegmentedTabControl(
      radius: const Radius.circular(10),
      backgroundColor: Colors.grey.shade300,
      indicatorColor: Colors.white,
      tabTextColor: Colors.black45,
      selectedTabTextColor: Colors.black,
      squeezeIntensity: 1,
      // height: 45,
      // tabPadding: const EdgeInsets.symmetric(horizontal: 10),
      textStyle: Theme.of(context).textTheme.bodyText1,
      // Options for selection
      // All specified values will override the [SegmentedTabControl] setting
      tabs: [
        SegmentTab(
          label: '월별',
          // For example, this overrides [indicatorColor] from [SegmentedTabControl]
        ),
        SegmentTab(
          label: '주별',
        ),
        const SegmentTab(label: '일별'),
      ],
    ),
  );
}
