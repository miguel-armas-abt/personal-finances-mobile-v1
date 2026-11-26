import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/commons/widgets/design_widgets.dart';
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
  late final DateTime _initialDate;
  late CurrencyCode _currency;
  bool _isSubmitting = false;

  bool get _isEditing => widget.expense != null;
  bool get _currencyNeedsSelection => !_currency.isKnown;

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    _initialDate = expense?.date.toLocal() ?? DateTime.now();
    _date = _initialDate;
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
    final dateFormat = DateFormat('d MMM yyyy · HH:mm', 'es_PE');
    return PopScope<bool>(
      canPop: !_isSubmitting && !_hasChanges,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop || _isSubmitting) return;
        final discard = await confirmDesignAction(
          context,
          title: 'Descartar cambios',
          message: 'Se perderán los datos que aún no guardaste.',
          action: 'Descartar cambios',
        );
        if (discard && context.mounted) Navigator.pop(context);
      },
      child: DesignPage(
        title: _isEditing ? 'Editar gasto' : 'Nuevo gasto',
        child: Form(
          key: _formKey,
          onChanged: () => setState(() {}),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
                  children: [
                    Text(
                      _currencyNeedsSelection
                          ? 'Completa el monto y selecciona la moneda correcta'
                          : _isEditing
                          ? 'Actualiza los datos del movimiento'
                          : 'Registra un movimiento manual',
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Monto',
                        hintText: _currencyNeedsSelection
                            ? '0.00'
                            : '${_currency.symbol} 0.00',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: _requiredPositiveAmount,
                    ),
                    const SizedBox(height: 11),
                    DropdownButtonFormField<CurrencyCode>(
                      initialValue: _currency,
                      decoration: InputDecoration(
                        labelText: 'Moneda',
                        helperText: _currencyNeedsSelection
                            ? 'No se pudo inferir. Selecciona PEN o USD.'
                            : null,
                      ),
                      items: [
                        for (final currency in CurrencyCode.values)
                          DropdownMenuItem(
                            value: currency,
                            child: Text(
                              currency.isKnown
                                  ? currency.code
                                  : 'UNKNOWN · sin definir',
                            ),
                          ),
                      ],
                      validator: (value) => value == null || !value.isKnown
                          ? 'Selecciona PEN o USD para continuar.'
                          : null,
                      onChanged: (value) {
                        if (value != null) setState(() => _currency = value);
                      },
                    ),
                    const SizedBox(height: 11),
                    Card(
                      child: ListTile(
                        title: const Text('Fecha y hora'),
                        subtitle: Text(dateFormat.format(_date)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _pickDate,
                      ),
                    ),
                    if (!_isEditing) ...[
                      const SizedBox(height: 11),
                      TextFormField(
                        controller: _sourceController,
                        decoration: const InputDecoration(labelText: 'Origen'),
                        validator: _requiredText,
                      ),
                    ],
                    const SizedBox(height: 11),
                    TextFormField(
                      controller: _recipientController,
                      decoration: const InputDecoration(
                        labelText: 'Destinatario',
                        hintText: 'Ej. Mercado Central',
                      ),
                    ),
                    const SizedBox(height: 11),
                    TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        labelText: 'Categoría',
                        hintText: 'Ej. Alimentación',
                      ),
                      validator: _isEditing ? _requiredText : null,
                    ),
                    const SizedBox(height: 11),
                    TextFormField(
                      controller: _commentsController,
                      decoration: InputDecoration(
                        labelText: 'Comentario',
                        hintText: _isEditing ? null : 'Opcional',
                      ),
                      maxLines: 3,
                      minLines: 1,
                      validator: _isEditing ? _requiredText : null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isSubmitting ? null : _submit,
                    child: Text(_isSubmitting ? 'Guardando…' : 'Guardar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _hasChanges {
    final expense = widget.expense;
    return _amountController.text !=
            (expense == null ? '' : formatMinorUnits(expense.money.amount)) ||
        _sourceController.text != (expense?.source ?? 'MANUAL') ||
        _recipientController.text != (expense?.recipient ?? '') ||
        _categoryController.text != (expense?.category ?? '') ||
        _commentsController.text != (expense?.comments ?? '') ||
        _currency != (expense?.money.currency ?? CurrencyCode.pen) ||
        _date != _initialDate;
  }

  Future<void> _pickDate() async {
    final firstDate = DateTime(2020);
    final lastDate = DateTime.now().add(const Duration(days: 365));
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: _date.isBefore(firstDate) ? _date : firstDate,
      lastDate: _date.isAfter(lastDate) ? _date : lastDate,
    );
    if (pickedDate == null || !mounted) {
      return;
    }
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_date),
    );
    if (pickedTime == null || !mounted) {
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
        Navigator.pop(context, true);
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
