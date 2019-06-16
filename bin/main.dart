import 'dart:io';
import 'package:prompter_sg/prompter_sg.dart';
import 'package:converter/src/converter.dart';


void main() {
  final prompter = new Prompter();
  final choice = prompter.askBinary('Are you here to convert an image?');
  if (!choice) {
    exit(0);
  }

  final format = prompter.askMultiple(
      'Select a format to convert to', buildFormatOptions());
  final selectedFile =prompter.askMultiple('Select an image to convert', buildFileOptions());

  final newPath=convertertImage(selectedFile, format);

  final shouldOpen = prompter.askBinary('Open the image?');
  if(shouldOpen){
    Process.run('open', [newPath]);
  }





}

List<Option> buildFileOptions() {
  //get reference to current working directory
   //find all the files and folders in the directory
  //Look through that list and finad all images


  return Directory.current.listSync().where((entity){
    return FileSystemEntity.isFileSync(entity.path) && entity.path.contains(new RegExp(r'\.(png|jpg|jpeg)')); 
  }).map((entity){
    final filename= entity.path.split(Platform.pathSeparator).last;//available for windows,macos
    return new Option(filename,entity);
  }).toList();


  //Take all images and create an opyion object out of each


}
List<Option> buildFormatOptions() {
  return [
    new Option('Convert to jpeg', 'jpeg'),
    new Option('Convert to png', 'png'),
  ];
}
