
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Car {
  Car(this.make, this.model, this.price);

  final String make;
  final int model;
  final int price;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataTablePage(),
    );
  }
}

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  int? sortColumnIndex;
  bool sortAscending = true;

  final List<Car> cars = [
    Car('Honda', 2021, 35000),
    Car('Toyota', 2011, 6000),
    Car('BMW', 2010, 9000),
  ];

  void sortBy(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;

      cars.sort((a, b) {
        int result;

        if (columnIndex == 0) {
          result = a.make.compareTo(b.make);
        } else if (columnIndex == 1) {
          result = a.model.compareTo(b.model);
        } else {
          result = a.price.compareTo(b.price);
        }

        return ascending ? result : -result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTable with Sorting'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          headingRowColor:
              WidgetStateProperty.all<Color>(Colors.grey),
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          columns: [
            DataColumn(
              label: const Text('Car Make'),
              onSort: (columnIndex, ascending) {
                sortBy(columnIndex, ascending);
              },
            ),
            DataColumn(
              label: const Text('Model'),
              onSort: (columnIndex, ascending) {
                sortBy(columnIndex, ascending);
              },
            ),
            DataColumn(
              label: const Text('Price'),
              numeric: true,
              onSort: (columnIndex, ascending) {
                sortBy(columnIndex, ascending);
              },
            ),
          ],
          rows: cars.map((car) {
            return DataRow(
              cells: [
                DataCell(Text(car.make)),
                DataCell(Text(car.model.toString())),
                DataCell(Text(car.price.toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
