
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ticket_scan/models/verification.dart';
import 'package:ticket_scan/providers/ticket_provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../providers/auth_provider.dart';
import '../routes/route.dart';

class PreviousScansScreen extends StatefulWidget{
  const PreviousScansScreen({super.key});

  @override
  createState() => PreviousScansScreenState();
}

class PreviousScansScreenState extends State<PreviousScansScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TicketProvider>(context, listen: false).previousVerifications(context);
    });
  }

  Widget _getLoading(){
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.limeAccent,
      ),
    );
  }

  Widget _getList(TicketProvider provider){
    return ListView.builder(
        itemCount: provider.verifications!.length,
        itemBuilder: (BuildContext context, int index){
          Verification? verification = provider.verifications!.elementAt(index);
          return ListTile(
              title: Text("${verification!.exhibitionName}"),
              subtitle: Text("${verification.name}"),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          SystemNavigator.pop();
          return false;
        },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Previous Scans"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: (){
                  Provider.of<TicketProvider>(context, listen: false).previousVerifications(context);
                },
                icon: const Icon(Icons.refresh)
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Log Out")
                  ),
                ];
              },
              onSelected: (value){
                if(value == 0){
                  Provider.of<AuthProvider>(context, listen: false).logout(context);
                }
              },
            )
          ],
        ),
        body: Consumer<TicketProvider>(
          builder: (context,provider,child){
            return provider.loading ? _getLoading(): _getList(provider);
          },
        ),
        floatingActionButton:Consumer<TicketProvider>(
          builder: (context,provider,child){
            return FloatingActionButton(
              child: const Icon(Icons.document_scanner),
              onPressed: () async{
                var status = await Permission.camera.request();
                if(status.isGranted){
                  String? cameraScanResult = await scanner.scan();
                  String ticketCode = cameraScanResult!.split("\n")[0].split(":")[1] ?? "";
                  provider.verify(context, ticketCode);
                }else{
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error!!!"),
                          content: const Text("Camera Permission is needed to Scan the QR code"),
                          actions: [
                            TextButton(
                              child: const Text("Close"),
                              onPressed: () {
                                Routes.router.pop(context);
                              },
                            )
                          ],
                        );
                      }
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

}
