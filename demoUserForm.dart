// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class RegistrationForm extends StatefulWidget {
//   @override
//   _RegistrationFormState createState() => _RegistrationFormState();
// }
//
// class _RegistrationFormState extends State<RegistrationForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _mobileController = TextEditingController();
//   DateTime? _selectedDate;
//   String? _selectedGender;
//   Set<String> _selectedHobbies = {};
//
//   final List<String> _hobbiesOptions = [
//     'Reading',
//     'Sports',
//     'Music',
//     'Traveling',
//     'Cooking',
//     'Gaming'
//   ];
//
//   final _pagePadding = EdgeInsets.symmetric(horizontal: 24);
//   final _animationDuration = Duration(milliseconds: 400);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal.shade300,
//       body: Center(
//         child: SingleChildScrollView(
//           child: TweenAnimationBuilder(
//             tween: Tween<double>(begin: 0, end: 1),
//             duration: _animationDuration,
//             builder: (context, double value, child) {
//               return Transform.scale(
//                 scale: Curves.easeOut.transform(value),
//                 child: child,
//               );
//             },
//             child: Container(
//               margin: EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 15,
//                     offset: Offset(0, 5),
//                   )
//                 ],
//               ),
//               padding: EdgeInsets.all(24),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _buildAnimatedField(
//                       child: TextFormField(
//                         controller: _firstNameController,
//                         decoration: InputDecoration(
//                           labelText: 'First Name',
//                           prefixIcon: Icon(Icons.person),
//                         ),
//                         validator: (value) =>
//                         value!.isEmpty ? 'Please enter first name' : null,
//                       ),
//                       delay: 0,
//                     ),
//                     SizedBox(height: 16),
//                     _buildAnimatedField(
//                       child: TextFormField(
//                         controller: _lastNameController,
//                         decoration: InputDecoration(
//                           labelText: 'Last Name',
//                           prefixIcon: Icon(Icons.people),
//                         ),
//                         validator: (value) =>
//                         value!.isEmpty ? 'Please enter last name' : null,
//                       ),
//                       delay: 100,
//                     ),
//                     SizedBox(height: 16),
//                     _buildAnimatedField(
//                       child: TextFormField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           prefixIcon: Icon(Icons.email),
//                         ),
//                         validator: (value) =>
//                         !value!.contains('@') ? 'Invalid email' : null,
//                       ),
//                       delay: 200,
//                     ),
//                     SizedBox(height: 16),
//                     _buildAnimatedField(
//                       child: TextFormField(
//                         controller: _mobileController,
//                         decoration: InputDecoration(
//                           labelText: 'Mobile',
//                           prefixIcon: Icon(Icons.phone),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         validator: (value) => value!.length != 10
//                             ? 'Invalid mobile number'
//                             : null,
//                       ),
//                       delay: 300,
//                     ),
//                     SizedBox(height: 16),
//                     _buildAnimatedField(
//                       child: InkWell(
//                         onTap: () => _selectDate(context),
//                         child: InputDecorator(
//                           decoration: InputDecoration(
//                             labelText: 'Date of Birth',
//                             prefixIcon: Icon(Icons.calendar_today),
//                           ),
//                           child: Text(
//                             _selectedDate != null
//                                 ? DateFormat('MM/dd/yyyy').format(_selectedDate!)
//                                 : 'Select date',
//                           ),
//                         ),
//                       ),
//                       delay: 400,
//                     ),
//                     SizedBox(height: 24),
//                     _buildAnimatedField(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Gender', style: TextStyle(color: Colors.grey[600])),
//                           Row(
//                             children: [
//                               _buildGenderRadio('Male', 'Male'),
//                               _buildGenderRadio('Female', 'Female'),
//                               _buildGenderRadio('Other', 'Other'),
//                             ],
//                           ),
//                         ],
//                       ),
//                       delay: 500,
//                     ),
//                     SizedBox(height: 24),
//                     _buildAnimatedField(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Hobbies', style: TextStyle(color: Colors.grey[600])),
//                           Wrap(
//                             spacing: 8,
//                             children: _hobbiesOptions.map((hobby) {
//                               return FilterChip(
//                                 label: Text(hobby),
//                                 selected: _selectedHobbies.contains(hobby),
//                                 onSelected: (selected) {
//                                   setState(() {
//                                     if (selected) {
//                                       _selectedHobbies.add(hobby);
//                                     } else {
//                                       _selectedHobbies.remove(hobby);
//                                     }
//                                   });
//                                 },
//                                 selectedColor: Colors.teal.shade100,
//                                 checkmarkColor: Colors.teal,
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//                       delay: 600,
//                     ),
//                     SizedBox(height: 32),
//                     _buildAnimatedField(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal,
//                           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         onPressed: _submitForm,
//                         child: Text('Submit', style: TextStyle(fontSize: 18)),
//                       ),
//                       delay: 700,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAnimatedField({required Widget child, required int delay}) {
//     return TweenAnimationBuilder(
//       tween: Tween<double>(begin: 0, end: 1),
//       duration: _animationDuration,
//       curve: Curves.easeInOut,
//       builder: (context, double value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(0, (1 - value) * 20),
//             child: child,
//           ),
//         );
//       },
//       child: child,
//     );
//   }
//
//   Widget _buildGenderRadio(String gender, String value) {
//     return Expanded(
//       child: ListTileTheme(
//         horizontalTitleGap: 0,
//         child: RadioListTile<String>(
//           title: Text(gender),
//           value: gender,
//           groupValue: _selectedGender,
//           onChanged: (value) => setState(() => _selectedGender = value),
//           activeColor: Colors.teal,
//           dense: true,
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != _selectedDate)
//       setState(() => _selectedDate = picked);
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Handle form submission
//       print('Form submitted');
//     }
//   }
// }
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class MetromomyForm extends StatefulWidget {
  @override
  _MetromomyFormState createState() => _MetromomyFormState();
}

class _MetromomyFormState extends State<MetromomyForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _gender = 'Male';
  List<String> _hobbies = [];
  DateTime? _dateOfBirth;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    // Start the animation
    _controller!.forward();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed
    _controller!.dispose();
    super.dispose();
  }

  Widget _buildAnimatedField(Widget child, int index) {
    // Create a staggered animation for each field
    final animation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Interval(
          index * 0.1,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    return SlideTransition(
      position: animation,
      child: FadeTransition(
        opacity: _controller!,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metromomy Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // First Name Field
              _buildAnimatedField(
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                1,
              ),
              SizedBox(height: 16),
              // Last Name Field
              _buildAnimatedField(
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                2,
              ),
              SizedBox(height: 16),
              // Email Field
              _buildAnimatedField(
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                3,
              ),
              SizedBox(height: 16),
              // Mobile Number Field
              _buildAnimatedField(
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty || value!.length != 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
                4,
              ),
              SizedBox(height: 16),
              // Date of Birth Field
              _buildAnimatedField(
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(1990),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateOfBirth = picked;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    child: _dateOfBirth == null
                        ? Text('Select your date of birth')
                        : Text('${_dateOfBirth!.toLocal()}'.split(' ')[0]),
                  ),
                ),
                5,
              ),
              SizedBox(height: 16),
              // Gender Radio Buttons
              _buildAnimatedField(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Gender',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                    ),
                    ListTile(
                      title: const Text('Male'),
                      leading: Radio(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Other'),
                      leading: Radio(
                        value: 'Other',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                6,
              ),
              SizedBox(height: 16),
              // Hobbies Selection Field
              _buildAnimatedField(
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hobbies (separated by commas)',
                    prefixIcon: Icon(Icons.list),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _hobbies = value.split(',').map((hobby) => hobby.trim()).toList();
                    });
                  },
                ),
                7,
              ),
              SizedBox(height: 32),
              // Submit Button with Animation
              _buildAnimatedField(
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Submitting your information...')),
                        );
                      }
                    },
                  ),
                ),
                8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
