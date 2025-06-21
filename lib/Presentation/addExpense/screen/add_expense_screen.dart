import 'package:intl/intl.dart';
import 'package:tracker/Index/index.dart';

class AddExpenseScreen extends StatefulWidget {
  final VoidCallback? onExpenseAdded;

  const AddExpenseScreen({super.key, this.onExpenseAdded});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final attachController = TextEditingController();
  final categoryController = TextEditingController();

  CategoryItem? selectedCategory = CategoryItem(
    "Groceries",
    Icons.shopping_cart,
    Colors.blue.shade100,
  );

  DateTime? _selectedDate;

  String selectedCurrency = 'USD';

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Pick Image'),
              onTap: () async {
                Navigator.of(context).pop();
                final picker = ImagePicker();
                XFile? pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                attachController.text = pickedFile?.name ?? "";
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_file),
              title: Text('Pick File'),
              onTap: () async {
                Navigator.of(context).pop();
                FilePickerResult? result = await FilePicker.platform
                    .pickFiles();

                if (result != null) {
                  File file = File(result.files.single.path!);
                  attachController.text = file.path;
                  if (kDebugMode) {
                    print('Picked file: ${file.path}');
                  }
                } else {
                  if (kDebugMode) {
                    print('User canceled the picker');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Expense"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<AddExpenseBloc, AddExpenseState>(
        builder: (context, state) {
          if (state is ExchangeInitial) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: categoryController,
                      readOnly: true,
                      onTap: () => showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        isScrollControlled: true,
                        builder: (_) => Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              Center(
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              Text(
                                "Categories",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 50),
                              GridView.count(
                                crossAxisCount: 4,
                                shrinkWrap: true,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10,
                                physics: NeverScrollableScrollPhysics(),
                                children: Constants().categories.map((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();

                                      categoryController.text = item.label;
                                    },
                                    child: CategoryItemWidget(item: item),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                        hint: Text("select category"),
                        fillColor: ColorConstants.gray,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a amount';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hint: Text("\$50,000"),
                        fillColor: ColorConstants.gray,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () => _pickDate(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hint: Text("02/01/2025"),
                        fillColor: ColorConstants.gray,
                        filled: true,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Attach Receipt',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: attachController,
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a attachment';
                        }
                        return null;
                      },
                      onTap: () => _showPicker(context),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                        ),
                        hint: Text("upload image"),
                        fillColor: ColorConstants.gray,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Currency',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CurrencyDropdown(
                      selectedCurrency: selectedCurrency,
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(height: 40.h),
                    const Spacer(),
                    PrimaryButtonWidget(
                      title: 'Save',
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AddExpenseBloc>().add(
                            GetExchangeRateEvent(
                              ExchangeParams(
                                targetCurrency: selectedCurrency,
                                baseCode: 'USD',
                                amount: num.tryParse(amountController.text),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is ExchangeLoading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is ExchangeLoaded) {
            return SummeryWidget(
              category: categoryController.text,
              amount: amountController.text,
              date: dateController.text,
              attachment: attachController.text,
              currency: selectedCurrency,
              convertedAmount: state.exchange.conversionResult.toString(),
              onPressed: () async {
                final box = Hive.box<Expense>('expenses');

                final expense = Expense(
                  category: categoryController.text,
                  amount: num.tryParse(amountController.text)!,
                  usdAmount: state.exchange.conversionResult!,
                  date: DateFormat('dd/MM/yyyy').parse(dateController.text),
                  receiptPath: attachController.text,
                  currency: selectedCurrency,
                );

                await box.add(expense);

                selectedCategory = null;
                categoryController.clear();
                amountController.clear();
                dateController.clear();
                attachController.clear();
                selectedCurrency = "USD";
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<ExpensesBloc>().add(
                    LoadExpenses(isInitial: true),
                  );
                  context.read<AddExpenseBloc>().add(ResetExpense());
                });
                widget.onExpenseAdded?.call();
              },
            );
          } else if (state is ExchangeError) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
