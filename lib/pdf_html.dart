import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

Future<String> pdfhtml() async {
  var htmlContent = """
<!DOCTYPE html>
<html>
<head>
  <style>
  table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
  }
  th, td, p {
    padding: 5px;
    text-align: left;
  }
  </style>
</head>
  <body>
    <h2>PDF Generated with flutter_html_to_pdf plugin</h2>
    <table style="width:100%">
      <caption>Sample HTML Table</caption>
      <tr>
        <th>Month</th>
        <th>Savings</th>
      </tr>
      <tr>
        <td>January</td>
        <td>100</td>
      </tr>
      <tr>
        <td>February</td>
        <td>50</td>
      </tr>
    </table>
    <p>Image loaded from web</p>
    <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
  </body>
</html>
""";

  final targetPath = await getTemporaryDirectory();
  final targetFileName = "example_pdf_file";

  final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
      htmlContent, targetPath.path, targetFileName);

  return generatedPdfFile.path;
}
