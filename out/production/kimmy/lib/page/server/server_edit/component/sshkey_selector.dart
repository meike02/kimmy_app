import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/component_function.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../../../data/store/sshkey_list_controller.dart';



class SSHKeySelector extends StatefulWidget {
  SSHKeySelector({super.key, required this.onChanged,required this.expanded});

  final controller = Get.put<SSHKeyListController>(SSHKeyListController());
  final void Function(String) onChanged;
  final void Function(bool) expanded;

  @override
  State<StatefulWidget> createState() {
    return _SSHKeySelectorState();
  }
}
class _SSHKeySelectorState extends State<SSHKeySelector>{
  bool extended = true;
  TextEditingController keyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createTextFormField(
          labelText: "密钥",
          readOnly: true,
          controller: keyController,
          onTap: () {
            setState(() {
              extended = !extended;
            });
            widget.expanded(extended);
          },
          onChanged: (value) => widget.onChanged(value)
        ),
        ConstrainedBox(
          // duration: const Duration(milliseconds: 240),
          // height: extended ? 240 : 0,
          constraints: BoxConstraints(
            maxHeight: extended ? 180 : 0
          ),
          child:GetBuilder<SSHKeyListController>(builder: (sshKeyController) {
            final sshKeyList = sshKeyController.modelList;
            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context,index) {
                  if(index == 30){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_rounded)
                      ],
                    ).intoInkWell(
                        onTap: (){}
                    );
                  }
                  final sshKeyInfo = sshKeyList[0];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sshKeyInfo.name),
                      Text(sshKeyInfo.type)
                    ],
                  ).intoInkWell(onTap: (){
                    keyController.text = sshKeyInfo.name;
                    setState(() {
                      extended = false;
                    });
                    widget.expanded(extended);
                  });
                },
                itemCount: 30 + 1,
              ),
            );
          }),
        )
      ],
    );
  }

}