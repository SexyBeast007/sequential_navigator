import 'package:flutter/material.dart';

class PageSliver {

  /*
    * This is an example builder for page content for this Sequential Navigator
    * [pageSliverBuilder()] is page content layout creator
  */

  /// Screen content example for demo
  SliverChildBuilderDelegate pageSliverBuilder(MaterialColor color) {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.all(15),
          child: Container(
            color: color[100 * (index % 9 + 1)],
            height: 80,
            alignment: Alignment.center,
            child: const Text(
              '',
              style: TextStyle(fontSize: 30),
            ),
          ),
        );
      },
      childCount: 10,
    );
  }

  SliverChildBuilderDelegate get red {
    return pageSliverBuilder(Colors.red);
  }

  SliverChildBuilderDelegate get blue {
    return pageSliverBuilder(Colors.blue);
  }

  SliverChildBuilderDelegate get green {
    return pageSliverBuilder(Colors.green);
  }

  SliverChildBuilderDelegate get yellow {
    return pageSliverBuilder(Colors.yellow);
  }

  SliverChildBuilderDelegate get purple {
    return pageSliverBuilder(Colors.purple);
  }

  SliverChildBuilderDelegate get indigo {
    return pageSliverBuilder(Colors.indigo);
  }

  SliverChildBuilderDelegate get pink {
    return pageSliverBuilder(Colors.pink);
  }
}
