import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/components/invoiceComponent/all_invoice.dart';

import '../../constants.dart';

class InvoiceList extends StatefulWidget {
  final String name;
  InvoiceList({this.name});

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final business = Provider.of<List<Business>>(context) ?? [];
    if (business != []) {
      return ListView.builder(
        itemCount: business.length,
        itemBuilder: (context, index) {
          return AllInvoice(
              color: KCustomCompanyOrdersStatus,
              businessId: business[index].uid,
              name: widget.name,
              onTapBox: () {
                print("yes");
              });
        },
      );
    }
  }
}
