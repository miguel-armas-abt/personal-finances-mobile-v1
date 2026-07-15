import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_controller.dart';
import 'package:personal_finances_mobile_v1/commons/logging/app_logger.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_write_request.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/expenses_controller.dart';

class ExpenseFormPage extends ConsumerStatefulWidget {
  const ExpenseFormPage({this.expense, super.key});

  final Expense? expense;

  @override
  ConsumerState<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends ConsumerState<ExpenseFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;
  late final TextEditingController _sourceController;
  late final TextEditingController _recipientController;
  late final TextEditingController _categoryController;
  late final TextEditingController _commentsController;
  late DateTime _date;
  late CurrencyCode _currency;
  bool _isSubmitting = false;

  bool get _isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    _date = expense?.date ?? DateTime.now();
    _currency = expense?.money.currency ?? CurrencyCode.pen;
    _amountController = TextEditingController(
      text: expense == null ? '' : formatMinorUnits(expense.money.amount),
    );
    _sourceController = TextEditingController(
      text: expense?.source ?? 'MANUAL',
    );
    _recipientController = TextEditingController(
      text: expense?.recipient ?? '',
    );
    _categoryController = TextEditingController(text: expense?.category ?? '');
    _commentsController = TextEditingController(text: expense?.comments ?? '');
  }

  @override
  void dispose() {
    _amountController.dispose();
    _sourceController.dispose();
    _recipientController.dispose();
    _categoryController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm', 'es_PE');

    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Editar gasto' : 'Nuevo gasto')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: _requiredPositiveAmount,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<CurrencyCode>(
                initialValue: _currency,
                decoration: const InputDecoration(
                  labelText: 'Moneda',
                  prefixIcon: Icon(Icons.currency_exchange),
                ),
                items: CurrencyCode.values
                    .map(
                      (currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency.code),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _currency = value);
                  }
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event),
                title: const Text('Fecha'),
                subtitle: Text(dateFormat.format(_date)),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sourceController,
                enabled: !_isEditing,
                decoration: const InputDecoration(
                  labelText: 'Origen',
                  prefixIcon: Icon(Icons.source_outlined),
                ),
                validator: _requiredText,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  labelText: 'Destinatario',
                  prefixIcon: Icon(Icons.storefront_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                validator: _isEditing ? _requiredText : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _commentsController,
                decoration: const InputDecoration(
                  labelText: 'Comentario',
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
                minLines: 2,
                maxLines: 3,
                validator: _isEditing ? _requiredText : null,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _isSubmitting ? null : _submit,
                icon: _isSubmitting
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate == null || !mounted) {
      return;
    }
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_date),
    );
    if (pickedTime == null) {
      return;
    }
    setState(() {
      _date = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    try {
      setState(() => _isSubmitting = true);
      final session = ref.read(authControllerProvider).session;
      final request = ExpenseWriteRequest(
        userEmail: session?.user.email,
        date: _date,
        currency: _currency,
        amount: parseMinorUnits(_amountController.text.replaceAll(',', '.')),
        source: _sourceController.text,
        recipient: _recipientController.text,
        category: _categoryController.text,
        comments: _commentsController.text,
      );

      final controller = ref.read(expensesControllerProvider.notifier);
      final saved = _isEditing
          ? await controller.update(
              expenseId: widget.expense!.id,
              request: request,
            )
          : await controller.create(request);

      if (!mounted) {
        return;
      }
      if (saved) {
        context.pop();
        return;
      }

      final message = ref.read(expensesControllerProvider).message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'No se pudo guardar el gasto.')),
      );
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Expense submit failed',
        name: 'app.expenses',
        error: error,
        stackTrace: stackTrace,
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo guardar el gasto.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String? _requiredPositiveAmount(String? value) {
    final amount = tryParseMinorUnits((value ?? '').replaceAll(',', '.'));
    if (amount == null || amount <= 0) {
      return 'Ingresa un monto mayor a cero.';
    }
    return null;
  }

  String? _requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo requerido.';
    }
    return null;
  }
}
