 import 'package:flutter/material.dart';
 import 'package:flutter/material.dart';

 class MyApp1 extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: MyHomePage(),
     );
   }
 }

 class MyHomePage extends StatefulWidget {
   @override
   _MyHomePageState createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
   List<String> items = ['Item 1', 'Item 2', 'Item 3'];
   Set<int> selectedItems = Set<int>();
   bool isSelectionMode = false;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Multi-Selection Dismissible Example'),
         actions: [
           if (isSelectionMode)
             IconButton(
               icon: Icon(Icons.delete),
               onPressed: () {
                 // Delete selected items
                 List<String> itemsToRemove = [];
                 for (int index in selectedItems) {
                   itemsToRemove.add(items[index]);
                 }
                 items.removeWhere((item) => itemsToRemove.contains(item));
                 selectedItems.clear();
                 setState(() {
                   isSelectionMode = false;
                 });
               },
             ),
         ],
       ),
       body: ListView.builder(
         itemCount: items.length,
         itemBuilder: (context, index) {
           final item = items[index];
           return Dismissible(
             key: Key(item),
             onDismissed: (direction) {
               items.removeAt(index);

             },
             background: Container(
               color: Colors.red,
               child: Icon(Icons.delete, color: Colors.white),
               alignment: Alignment.centerRight,
               padding: EdgeInsets.only(right: 16.0),
             ),
             child: ListTile(
               title: Text(item),
               onLongPress: () {
                 // Enter selection mode on long-press
                 setState(() {
                   isSelectionMode = true;
                 });
                 // Toggle selection on long-press
                 if (selectedItems.contains(index)) {
                   selectedItems.remove(index);
                 } else {
                   selectedItems.add(index);
                 }
               },
               leading: isSelectionMode
                   ? Checkbox(
                 value: selectedItems.contains(index),
                 onChanged: (value) {
                   setState(() {
                     if (value != null) {
                       if (value) {
                         selectedItems.add(index);
                       } else {
                         selectedItems.remove(index);
                       }
                     }
                   });
                 },
               )
                   : null,
               tileColor: selectedItems.contains(index) ? Colors.grey[300] : null,
               onTap: () {
                 // Toggle selection on tap if in selection mode
                 if (isSelectionMode) {
                   setState(() {
                     if (selectedItems.contains(index)) {
                       selectedItems.remove(index);
                     } else {
                       selectedItems.add(index);
                     }
                   });
                 }
               },
             ),
           );
         },
       ),
     );
   }
 }
