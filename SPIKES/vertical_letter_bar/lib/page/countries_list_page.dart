import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';


class _AZItem extends ISuspensionBean{
  final String title;
  final String tag;

  _AZItem({
    required this.title,
    required this.tag,
  });

  @override
  String getSuspensionTag() => tag;
}

class CountriesListPage extends StatefulWidget {

  final List<String> items;
  final ValueChanged<String> onClickedItem;

  const CountriesListPage({
    Key? key,
    required this.items,
    required this.onClickedItem,
  }) : super(key: key);

  @override
  State<CountriesListPage> createState() => _CountriesListPageState();
}

class _CountriesListPageState extends State<CountriesListPage> {

  List<_AZItem> items = [];

  @override
  void initState() {
    super.initState();

    initList(widget.items);
  }

  void initList(List<String> items) {
    this.items = items.map((item) => _AZItem(title: item, tag: item[0].toUpperCase())).toList();

    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      padding: EdgeInsets.all(16),
      data: items,
      indexBarItemHeight: MediaQuery.of(context).size.height / 30,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildListItem(item);
      },
      indexHintBuilder: (context, hint) => Container(
        alignment: Alignment.center,
        width: 60,
        height: 60,
        decoration: BoxDecoration(color: Colors.blue.shade100, shape: BoxShape.rectangle),
        child: Text(
          hint,
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      indexBarMargin: EdgeInsets.all(10),
      indexBarOptions: IndexBarOptions(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
        ),
        //  IF WE NEED TO DECORATION THE LETTER SELECTED ON THE BAR
        //  IF WE NEED IT WE WILL NEED TO CHECK IT AN ERROR WITH THE DECORATION LINE 76
        //  needRebuild: true,
        // selectTextStyle: TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        // selectItemDecoration: BoxDecoration(
        //   color: Colors.transparent,
        // ),
        indexHintAlignment: Alignment.centerRight,
        indexHintOffset: Offset(-20,0),
        ),
    );
  }

    Widget _buildListItem(_AZItem item) {

      final tag = item.getSuspensionTag();

      final offstage = !item.isShowSuspension;

      return Column(
        children: [
          Offstage(offstage: offstage, child: buildHeader(tag)),
          Container(
            margin: EdgeInsets.only(right: 16),
            child: ListTile(
              title: Text(item.title),
              onTap: () => widget.onClickedItem(item.title),
            ),
          ),
        ],
      );
    }

    Widget buildHeader(String tag) => Container(
      height: 40,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.only(left: 16),
      color: Colors.grey.shade300,
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
}