import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;






class FirstScreenbloc {
  File _image;
  String _uploadedFileURL;
  bool isLoading = false;
  FirstScreenbloc()
  {
    _image=null;
    _isLoading.add(false);
  //  _actionController.stream.listen(chooseFile());
  }
  final _fileStream = PublishSubject<File>();
  final _fileUrlStream = PublishSubject<String>();
  final _isLoadingStream = PublishSubject<bool>();


  StreamController _actionController = StreamController();
  StreamSink get choseImage => _actionController.sink;
  Stream get image => _fileStream.stream;
  Sink get _addfile => _fileStream.sink;
  Stream get imageUrl => _fileUrlStream.stream;
  Sink get _addfileUrl => _fileUrlStream.sink;
  Stream get isLoadingresult => _isLoadingStream.stream;
  Sink get _isLoading => _isLoadingStream.sink;

   chooseFile() async {
     print("choose");
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {

        _image = image;
        _addfile.add(_image);

    });
  }
 Future uploadFile(String title) async {

      isLoading = true;
      _isLoading.add(isLoading);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {

        _uploadedFileURL = fileURL;
        _addfileUrl.add(_uploadedFileURL);
        print(fileURL.toString());
        uploadingData(_uploadedFileURL,title);
        isLoading = false;
        _isLoading.add(isLoading);


    });
  }
  Future<void> uploadingData(String fileURL,String title) async {
    print("uploading data");
    await Firestore.instance.collection("tested").add({
      'lat': 10,
      'long': 10,
      'url': fileURL,
      'title':title
    });
  }
}

final firstscreenbloc = FirstScreenbloc();
