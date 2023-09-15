import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:prognosticare/components/validation.dart';
import 'package:prognosticare/src/api/service/forgotPasswordService.dart';
import 'package:prognosticare/src/pages/auth/agendamentos.dart';
import 'package:prognosticare/src/pages/auth/sign_in_screen.dart';
import 'package:prognosticare/src/pages/common_widgets/custom_text_field.dart';

class ProntuarioDialog extends StatelessWidget {
  const ProntuarioDialog({Key? key});

  Future<bool?> prontuarioDialog(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Titulo
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Prontuário',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Agendamentos()));
                        },
                        child: const Text(
                          'Agendamentos',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                         // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Acompanhamentos()));
                        },
                        child: const Text(
                          'Acompanhamentos',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
