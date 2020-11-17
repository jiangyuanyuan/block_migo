import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:migo/common/commview/commback_view.dart';

class FilePage extends StatelessWidget {
  final Map params;
  const FilePage({Key key, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: CommbackView(
        titles: params["title"],
        onPop: () => Navigator.pop(context),
        child: FileReaderView(
          filePath: params["path"],
        ),
      ),
    );
  }
}
