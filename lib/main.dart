import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String img = "assets/ngorder.png";
  final String img2 = "assets/fragile.png";
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
    final imageProvider =  AssetImage(img);
    final imageProvider2 =  AssetImage(img2);
    final image = await flutterImageProvider(imageProvider);
    final image2 = await flutterImageProvider(imageProvider2);

    pdf.addPage(
        pw.Page(
            pageFormat: format.landscape,
//        orientation: PageOrientation.landscape,
            build: (context){
              return pw.Expanded(
                fit: pw.FlexFit.tight,
                  child : pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                      width: 120,
                        height: 300,
                      padding: pw.EdgeInsets.all(8),
                        decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          image == null ? pw.Container(): pw.Image.provider(image, width: 50),
                          pw.Text("KERENID", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Lenggang Jakarta, Blok D-17, Jl. Medan Merdeka Selatan, Gambir , Jakarta Nomor Telepon +6287881454946",textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 12)),
                        ]
                      )
                  ),
                  pw.Container(
                      height: 300,
                      padding: pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("PO#11689:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 32)),
                            pw.Container(height: 8),
                            pw.Text("Kepada:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Text("vick"),
                            pw.Text("Jalanan"),
                            pw.Text("Kec. Selorejo, Kabupaten Blitar, 89685"),
                            pw.Text("Provinsi Jawa Timur"),
                            pw.Text("Telp: 0892223"),
                            pw.Spacer(flex: 2),
                            pw.Text("Pengirim:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Text("KerenID"),
                            pw.Spacer(),
                            pw.Text("Warehouse:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Spacer(),
                            pw.Text("Admin:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Text("Bambang"),
                          ]
                      )
                  ),
                  pw.Container(
                      height: 300,
                      padding: pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              child : pw.Row(
                                children: [
                                  pw.Container(width: 120),
                                  pw.BarcodeWidget(
                                    data: "PO#11689",
                                    drawText: false,
                                    width: 100,
                                    height: 20,
                                    barcode: pw.Barcode.telepen()
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(height:16 ),
                            pw.Text("Order (29 Desember 2020)", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                            pw.Row(
                                children : [
                                  pw.Text("Grosir Tas Chn22 Pink"),
                                  pw.Container(width: 80),
                                  pw.Text("1x", textAlign : pw.TextAlign.right,),
                                ]
                            ),
                            pw.Container(height: 16),
                            pw.BarcodeWidget(
                                data: "P410V03",
                                drawText: true,
                                width: 100,
                                height: 30,
                                barcode: pw.Barcode.telepen()
                            ),
                            pw.Container(height: 20),
                            pw.Row(
                                children : [
                                  pw.Text("Total Item:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 21)),
                                  pw.Container(width: 95),
                                  pw.Text("1", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 21,)),
                                ]
                            ),
                            pw.Container(height: 50),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                                children : [
                                  pw.Container(
                                    padding: pw.EdgeInsets.all(8),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 1),
                                    ),
                                    child : pw.Column(
                                      children: [
                                        pw.Text("SiCepat - REG (1 Kg)", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                                        pw.Text("Biaya Kirim: Rp13.000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                                      ]
                                    ),
                                  ),
                                  pw.Container(width: 10),
                                  pw.Container(
                                    padding: pw.EdgeInsets.all(8),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(width: 1),
                                    ),
                                    child : pw.Column(
                                        children: [
                                          pw.Text("NO RESI :", style: pw.TextStyle(fontWeight: pw.FontWeight.bold )),
                                        ]
                                    ),
                                  ),
                                 ],
                            ),
                          ],
                      ),
                  ),
                  pw.Container(
                    width: 150,
                    padding: pw.EdgeInsets.all(8),
                    height: 300,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(width: 1),
                    ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        image2 == null ? pw.Container(): pw.Image.provider(image2, width: 70),
                        pw.Text("FRAGILE", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 28 )),
                        pw.Text("JANGAN DIBANTING!!!"),
                      ],
                    ),
                  ),
                ],
              ),
              );
            }

        )
    );
    doc = pdf;
    return pdf.save();
  }

}


