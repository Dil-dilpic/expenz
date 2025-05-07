import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/expense_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpens;
  const AddNewScreen({
    super.key, 
    required this.addExpens});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  //state to check the income or Expense
  int _selectedMethode = 0;
  Expensecategory _expensecategory = Expensecategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selecteddate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
   _titleController.dispose();
   _descriptionController.dispose();
   _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethode == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethode = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                              child: Text("Expense", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _selectedMethode == 0 ? kWhite : kBlack,
                              ),),
                            ),
                            ),
                        ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMethode = 1;
                              });
                            },
                            child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                              child: Text("Income", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _selectedMethode == 1 ? kWhite : kBlack,
                              ),),
                            ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                //Amount feild
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("How Much?",
                        style: TextStyle(
                          fontSize: 22,
                          color: kLightGrey.withOpacity(0.8),
                          fontWeight: FontWeight.w600
                        ),),
                      const TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 60,
                        color: kWhite,
                        fontWeight: FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        hintText: "0",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: kWhite,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                      ],
                      
                    ),
                  ),
                ),
                // user dat form
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                  ),
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      child: Column(
                        children: [
                          //category selector dropdown
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              )
                            ),
                            items: _selectedMethode == 0 ? Expensecategory.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.name),
                            );
                          }).toList() : IncomeCategory.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.name),
                            );
                          }).toList() ,
                          value: _selectedMethode == 0 ? _expensecategory : _incomeCategory,
                          onChanged:(value) {  
                            setState(() {
                              _selectedMethode == 0 
                              ? _expensecategory = value as Expensecategory 
                              : _incomeCategory = value as IncomeCategory;
                            });                        
                          },),
                          const SizedBox(
                            height: 20,
                          ),
                          // tiitle field
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              )
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // description field
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              )
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // amount field
                          TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              )
                            ),
                          ),
                          SizedBox(height: 20,),
                          //date picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context, 
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020), 
                                    lastDate: DateTime(2030),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          _selecteddate = value;
                                        });
                                      }
                                    });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kMainColor,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: kWhite,),
                                          SizedBox(width: 10,),
                                          Text(
                                            "Select Date",
                                            style: TextStyle(
                                              color: kWhite,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selecteddate),
                                style: const TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context, 
                                    initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                         _selectedTime = DateTime(
                                          _selecteddate.year,
                                          _selecteddate.month,
                                          _selecteddate.day,
                                          value.hour,
                                          value.minute,
                                        );
                                        });
                                      }
                                    });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kGreen,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: kWhite,),
                                          SizedBox(width: 10,),
                                          Text(
                                            "Select time",
                                            style: TextStyle(
                                              color: kWhite,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                               DateFormat.jm().format(_selectedTime),
                                style: const TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: kLightGrey,
                            thickness: 5,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //submit button
                          GestureDetector(
                            onTap: () async {
                              // save the expense or the income data to shared preference
                              List<Expense> loadedExpenses = await ExpenseServices().loadExpenses();
                              print(loadedExpenses.length);

                              //Create the expense to store
                              Expense expense = Expense(
                                id: loadedExpenses.length + 1, 
                                title: _titleController.text, 
                                amount: _amountController.text.isEmpty
                                  ? 0
                                  : double.parse(_amountController.text), 
                                category: _expensecategory, 
                                date: _selecteddate, 
                                time: _selectedTime, 
                                description: _descriptionController.text,
                                );

                                //add expense
                                widget.addExpens(expense);
                            },
                            child: CustomButton(
                              buttonName: "Add", 
                              buttonColor: _selectedMethode == 0 ? kRed : kGreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
      ),
      ),
    );
  }
}