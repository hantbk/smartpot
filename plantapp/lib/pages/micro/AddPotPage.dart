import 'package:flutter/material.dart';
import 'package:plantapp/pages/models/Plant.dart';

class AddPotPage extends StatefulWidget {
  final void Function(String name, Plant plant) onAddPot;

  const AddPotPage({super.key, required this.onAddPot});

  @override
  _AddPotPageState createState() => _AddPotPageState();
}

class _AddPotPageState extends State<AddPotPage> {
  final TextEditingController _nameController = TextEditingController();
  Plant? selectedPlant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Pot"),
        backgroundColor: const Color.fromRGBO(161, 207, 107, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Pot Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<Plant>(
              decoration: const InputDecoration(
                labelText: "Select Plant",
                border: OutlineInputBorder(),
              ),
              items: plants
                  .map(
                    (plant) => DropdownMenuItem(
                      value: plant,
                      child: Text(plant.name),
                    ),
                  )
                  .toList(),
              onChanged: (Plant? plant) {
                setState(() {
                  selectedPlant = plant;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(74, 173, 82, 1),
              ),
              onPressed: () {
                if (_nameController.text.isNotEmpty && selectedPlant != null) {
                  widget.onAddPot(_nameController.text, selectedPlant!);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill all fields"),
                    ),
                  );
                }
              },
              child: const Text("Add Pot"),
            ),
          ],
        ),
      ),
    );
  }
}
