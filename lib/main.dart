import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf_experiment/pdf_html.dart';
import 'package:pdf_experiment/pdf_view.dart';
import 'package:pdf_experiment/pdfpdf.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _pdfpdf = pdfpdf();
  final _pdfhtml = pdfhtml();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          FlatButton(
            onPressed: () async => OpenFile.open(await _pdfpdf),
            child: Text("pdf share"),
          ),
          FlatButton(
            onPressed: () => _pdfpdf.then((path) => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PdfViewer(path)))),
            child: Text("pdf pdf viewer"),
          ),
          FlatButton(
            onPressed: () async => OpenFile.open(await _pdfhtml),
            child: Text("pdf html share"),
          ),
          FlatButton(
            onPressed: () => _pdfhtml.then((path) => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PdfViewer(path)))),
            child: Text("pdf html pdf viewer"),
          ),
          FutureBuilder<String>(
            future: _pdfpdf,
            builder: (context, snapshot) => (snapshot.hasData)
                ? PdfDocumentLoader(
                    pageNumber: 1,
                    filePath: snapshot.data,
                  )
                : CircularProgressIndicator(),
          ),
          FutureBuilder<String>(
            future: _pdfhtml,
            builder: (context, snapshot) => (snapshot.hasData)
                ? PdfDocumentLoader(
                    pageNumber: 1,
                    filePath: snapshot.data,
                  )
                : CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
