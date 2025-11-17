import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationFormSheet extends StatefulWidget {
  const NotificationFormSheet({
    super.key,
    this.onSubmit,
  });

  final Function(String title, String body, DateTime? scheduledTime, String? payload)? onSubmit;

  @override
  State<NotificationFormSheet> createState() => _NotificationFormSheetState();
}

class _NotificationFormSheetState extends State<NotificationFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _payloadController = TextEditingController();
  bool _isScheduled = false;
  DateTime? _scheduledDate;
  TimeOfDay? _scheduledTime;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _payloadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Send Notification',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                title: const Text('Schedule Notification'),
                subtitle: const Text('Send immediately or schedule for later'),
                value: _isScheduled,
                onChanged: (value) {
                  setState(() {
                    _isScheduled = value;
                    if (!value) {
                      _scheduledDate = null;
                      _scheduledTime = null;
                    }
                  });
                },
                secondary: Icon(
                  _isScheduled ? Icons.schedule : Icons.send,
                  color: _isScheduled ? Colors.orange : Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter notification title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter notification message',
                  prefixIcon: Icon(Icons.message),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _payloadController,
                decoration: const InputDecoration(
                  labelText: 'Payload (Optional)',
                  hintText: 'Custom data to pass with notification',
                  prefixIcon: Icon(Icons.data_object),
                  border: OutlineInputBorder(),
                ),
              ),
              if (_isScheduled) ...[
                const SizedBox(height: 16),
                Text(
                  'Schedule Time',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_today),
                        label: Text(
                          _scheduledDate != null
                              ? '${_scheduledDate!.day}/${_scheduledDate!.month}/${_scheduledDate!.year}'
                              : 'Select Date',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickTime,
                        icon: const Icon(Icons.access_time),
                        label: Text(
                          _scheduledTime != null
                              ? '${_scheduledTime!.hour.toString().padLeft(2, '0')}:${_scheduledTime!.minute.toString().padLeft(2, '0')}'
                              : 'Select Time',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submit,
                icon: Icon(_isScheduled ? Icons.schedule : Icons.send),
                label: Text(_isScheduled ? 'Schedule Notification' : 'Send Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _scheduledDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _scheduledTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _scheduledTime = time;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isScheduled && (_scheduledDate == null || _scheduledTime == null)) {
      Get.snackbar(
        'Error',
        'Please select both date and time',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
      );
      return;
    }

    DateTime? scheduledTime;
    if (_isScheduled && _scheduledDate != null && _scheduledTime != null) {
      scheduledTime = DateTime(
        _scheduledDate!.year,
        _scheduledDate!.month,
        _scheduledDate!.day,
        _scheduledTime!.hour,
        _scheduledTime!.minute,
      );

      if (scheduledTime.isBefore(DateTime.now())) {
        Get.snackbar(
          'Error',
          'Scheduled time must be in the future',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.1),
        );
        return;
      }
    }

    final result = NotificationFormData(
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      payload: _payloadController.text.trim().isNotEmpty
          ? _payloadController.text.trim()
          : null,
      isScheduled: _isScheduled,
      scheduledTime: scheduledTime,
    );

    Get.back(result: result);
  }
}

class NotificationFormData {
  final String title;
  final String body;
  final String? payload;
  final bool isScheduled;
  final DateTime? scheduledTime;

  NotificationFormData({
    required this.title,
    required this.body,
    required this.payload,
    required this.isScheduled,
    required this.scheduledTime,
  });
}