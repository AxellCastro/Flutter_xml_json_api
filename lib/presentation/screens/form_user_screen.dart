import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormUserScreen extends StatefulWidget {
  const FormUserScreen({super.key});

  @override
  State<FormUserScreen> createState() => _FormUserScreenState();
}

class _FormUserScreenState extends State<FormUserScreen> {
  final nombreProductoController = TextEditingController();
  final precioProductoController = TextEditingController();
  final fechaController = TextEditingController();
  bool aceptaTerminos = false;
  String importado = '';
  String? categoria;

  final _formKey = GlobalKey<FormState>();

  void handleAceptar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Nombre del producto: ${nombreProductoController.text}');
      print('Precio del producto: ${precioProductoController.text}');
      print('Fecha de vencimiento: ${fechaController.text}');
      print('Importado: $importado');
      print('Categoría: $categoria');
      print('Acepta términos: $aceptaTerminos');
    }
  }

  void handleBorrar() {
    _formKey.currentState!.reset();
    nombreProductoController.clear();
    precioProductoController.clear();
    fechaController.clear();
    setState(() {
      aceptaTerminos = false;
      importado = '';
      categoria = null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        fechaController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.zero,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1.02,
              heightFactor: 0.79,
              child: Card(
                elevation: 50,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Formulario',
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 35,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          controller: nombreProductoController,
                          hintText: 'Nombre de producto',
                          icon: Icons.inventory_2,
                        ),
                        const SizedBox(height: 15),
                        _buildInputField(
                          controller: precioProductoController,
                          hintText: 'Precio de producto',
                          icon: Icons.price_change_sharp,
                          isNumeric: true,
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: _buildInputField(
                              controller: fechaController,
                              hintText: 'Fecha de vencimiento',
                              icon: Icons.calendar_month_rounded,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildRadioButtons(),
                        const SizedBox(height: 15),
                        _buildComboBox(),
                        _buildCheckBox(),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildButton(
                                buttonText: "Aceptar ",
                                onPressed: handleAceptar,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildButton(
                                buttonText: "Borrar",
                                onPressed: handleBorrar,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isNumeric = false,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: colors.primary),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 13,
          ),
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: colors.primary),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRadioButtons() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Importado'),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Si'),
                  value: 'Si',
                  groupValue: importado,
                  onChanged: (String? value) {
                    setState(() {
                      importado = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('No'),
                  value: 'No',
                  groupValue: importado,
                  onChanged: (String? value) {
                    setState(() {
                      importado = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComboBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: const Text(
          'Categoría del producto',
          style: TextStyle(fontSize: 13),
        ),
        value: categoria,
        onChanged: (String? newValue) {
          setState(() {
            categoria = newValue;
          });
        },
        items: <String>['Fruta', 'Tecnología', 'Hogar']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCheckBox() {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.only(left: 100),
      title: const Text(
        'Aceptar términos y condiciones',
        style: TextStyle(fontSize: 14),
      ),
      value: aceptaTerminos,
      onChanged: (bool? value) {
        setState(() {
          aceptaTerminos = value ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }

  Widget _buildButton({
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          buttonText,
          style: GoogleFonts.outfit(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
