/*
final ImagePicker imagePicker = ImagePicker();
List<XFile> imageFileList = [];

void selectImages() async {
  final List<XFile> selectedImages = await
  imagePicker.pickMultiImage();
  if (selectedImages.isNotEmpty) {
    imageFileList.addAll(selectedImages);
  }
  print("Image List Length:" + imageFileList.length.toString());
  setState((){});
}


SafeArea(
child: Stack(
children: [
GridView.builder(
itemCount: imageFileList.length,
gridDelegate:
SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2),
itemBuilder: (BuildContext context, int index) {
return Padding(
padding: const EdgeInsets.all(8.0),
child: Image.file(File(imageFileList[index].path),
fit: BoxFit.cover,),
);
}),
Positioned(
top: 20,
left: 20,
child: Icon(CupertinoIcons.arrow_left,size: 25,),
),
Positioned(
bottom: 20,
right: 20,
child: FloatingActionButton(
onPressed:(){
selectImages();
},
child: Icon(CupertinoIcons.photo_on_rectangle),
),
),
],
),
);*/
