import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/data/model/navigation_item_info.dart';
import 'package:kimmy/data/store/navigation_bar_controller.dart';
import 'package:kimmy/core/utils/extensions.dart';

class NavigationItem extends StatefulWidget{
  NavigationItem({
  super.key,
  required this.navigationItemInfo,
  required this.itemIndex});

  final NavigationItemInfo navigationItemInfo;
  final int itemIndex;
  final barController = Get.find<NavigationBarController>();

  @override
  State<StatefulWidget> createState() {
    return _NavigationItem();
  }
}

class _NavigationItem extends State<NavigationItem>{
  late bool selected;

  @override
  void initState() {
    selected = widget.barController.selectedIndex==widget.itemIndex;

    widget.barController.addListener(() {
      setState(() {
        selected = widget.barController.selectedIndex==widget.itemIndex;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected?Theme.of(context).colorScheme.secondaryContainer.editOpacity(0.4):Colors.transparent,
        borderRadius: BorderRadius.circular(100)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
              widget.navigationItemInfo.icon,
              size: 30,
              color: selected?Theme.of(context).colorScheme.onSecondaryContainer:null
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOutQuart,
              child :SizedBox(width: selected ? 10 : 0,)
          ),
          AnimatedSize(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOutQuart,
              child:Text(selected ? widget.navigationItemInfo.name:"")
              .editProp(
                  fontWeight: FontWeight.bold,
                  color: selected?Theme.of(context).colorScheme.onSecondaryContainer:null)
          )
        ],
      ),
    ).intoInkWell(
        onTap: (){
          widget.barController.select(widget.itemIndex);
        }
    );
  }
}