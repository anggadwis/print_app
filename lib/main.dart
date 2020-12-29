import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets/page.dart';
import 'package:printing/printing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var doc;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Print"),
          actions: [
            IconButton(icon: Icon(Icons.print), onPressed: () {
              Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) => doc.save());
            }),
            IconButton(icon: Icon(Icons.share), onPressed: () {
              Printing.sharePdf(bytes: doc.save(), filename: 'my-document.pdf');
            }),
          ],
        ),
        body: PdfPreview(
          pdfPreviewPageDecoration: BoxDecoration( border: Border.all(color: Colors.black, width: 1), color: Colors.white),
          useActions: false,
          build: (format) => _generatePdf(format, "Hello Word"),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async{
    final pdf = pw.Document();
    pdf.addPage(
        pw.Page(
            pageFormat: format.landscape,
//        orientation: PageOrientation.landscape,
            build: (context){
              return pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                      width: 200,
                        height: 100,
                        decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.SvgImage(svg: "https://cdn.pixabay.com/photo/2016/11/05/20/09/grooming-1801287_960_720.png", width: 50, height: 50),
                          pw.Text("KERENID", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Lenggang Jakarta, Blok D-17, Jl. Medan Merdeka Selatan, Gambir , Jakarta Nomor Telepon +6287881454946",textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 12)),
                        ]
                      )
                  ),
                  pw.Container(
                      width: 200,
                      height: 300,
                      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,

                          children: [
                            pw.Text("Kepada:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Text("vick"),
                            pw.Text("Jalanan"),
                            pw.Text("Kec. Selorejo, Kabupaten Blitar, 89685"),
                            pw.Text("Provinsi Jawa Timur"),
                            pw.Text("Telp: 0892223"),
                            pw.Spacer(flex: 6),
                            pw.Text("Pengirim:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Text("KerenID"),
                            pw.Spacer(),
                            pw.Text("Pengirim:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Spacer(),
                            pw.Text("Admin:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Text("Bambang"),
                          ]
                      )
                  ),
                  pw.Container(
                      width: 200,
                      height: 100,
                      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [ 
                            pw.BarcodeWidget(
                              data: "Tes",
                              width: 100,
                              height: 30,
                              barcode: pw.Barcode.telepen()
                            ),

                          ]
                      )
                  ),


                ],
              );
            }
        )
    );
    doc = pdf;
    return pdf.save();
  }

}


