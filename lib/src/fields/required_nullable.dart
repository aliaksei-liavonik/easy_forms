import 'package:easy_forms/easy_forms.dart';

/// Use [RequiredNullableFieldController] if the field's value can be null during filling the form,
/// but it should be non-null when the form is submitted.
class RequiredNullableFieldController<Value, ValidationError>
    extends FieldController<Value?, ValidationError> {
  RequiredNullableFieldController({
    required super.initialValue,
    required FieldValidator<Value, ValidationError> validator,
    required ValidationError nullValueError,
    String? debugLabel,
    bool autoValidate = false,
  }) : super(
          validator: (value) => _nullableFieldValidator(
            value: value,
            validator: validator,
            nullValueError: nullValueError,
          ),
          debugLabel: debugLabel,
          autoValidate: autoValidate,
        );

  static ValidationError? _nullableFieldValidator<Value, ValidationError>({
    required Value? value,
    required FieldValidator<Value, ValidationError> validator,
    required ValidationError nullValueError,
  }) {
    if (value == null) {
      return nullValueError;
    }
    return validator(value);
  }

  /// Returns validated non-null value of the field.
  /// Throws [StateError] if the field's value is null or invalid.
  Value get requiredValue {
    final value = this.value.value;
    final validationState = this.value.value;

    if (value != null) {
      return value;
    } else if (validationState == ValidationState.invalid) {
      throw StateError("The field's value is invalid.");
    } else {
      throw StateError("The field's value is null.");
    }
  }
}
