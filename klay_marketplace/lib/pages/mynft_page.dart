import 'package:flutter/material.dart';
import 'package:web3d/web3d.dart';
import 'package:get/get.dart';
import 'package:klaymarket/tools/nft_contract.dart';
class MyNFTPage extends StatefulWidget {
  const MyNFTPage({super.key});

  @override
  State<MyNFTPage> createState() => _MyNFTPageState();
}

class _MyNFTPageState extends State<MyNFTPage> {
  var syb ='';
  @override
  Widget build(BuildContext context) {
    final sc = Get.put(NftController());
    return MaterialApp(
      home: Container(
        child: Column(
          children: [
            Text(
              syb
            ),
            ElevatedButton(
              onPressed: () async{
                sc.connect();
                var message = '';
                final name = await sc.nftContract!.call<String>('name');
                message = name;
                debugPrint("Token Name is " + message);
              },
              child: Text('Check'),
            )
          ],
        ),
      )
    );
  }
}