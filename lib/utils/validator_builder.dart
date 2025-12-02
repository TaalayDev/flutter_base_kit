/// Function type for form field validation.
/// Takes a value of type [T] and returns an error message string if validation fails,
/// or null if validation passes.
typedef FormValidator<T> = String? Function(T? value);

/// Function type for custom validation error messages.
/// Takes the invalid value and returns a custom error message.
typedef ValidationMessageBuilder = String? Function(String? value);

/// A builder class for creating composable form field validators.
///
/// This class allows you to chain multiple validation rules and build
/// a single validator function that applies all rules in sequence.
///
/// Example usage:
/// ```dart
/// final validator = ValidatorBuilder()
///   .required()
///   .email()
///   .maxLength(100)
///   .build();
///
/// final error = validator('test@example.com'); // Returns null if valid
/// ```
class ValidatorBuilder {
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  // Basic international phone number regex
  // Allows formats like: +1234567890, 123-456-7890, (123) 456-7890
  static final _phoneRegex = RegExp(r'^\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$');

  // Only letters regex
  static final _lettersRegex = RegExp(r'^[a-zA-Z]+$');
  // Only digits regex
  static final _digitsRegex = RegExp(r'^\d+$');

  /// The list of validation functions to be applied.
  final List<FormValidator<String>> _validators;

  /// Creates a new [ValidatorBuilder] instance.
  ///
  /// Optionally accepts an initial list of validators.
  ValidatorBuilder([List<FormValidator<String>> validators = const []]) : _validators = List.of(validators);

  /// Adds a custom validator function to the builder.
  ///
  /// Example:
  /// ```dart
  /// builder.add((value) {
  ///   if (value != 'expected') {
  ///     return 'Value must be "expected"';
  ///   }
  ///   return null;
  /// });
  /// ```
  ValidatorBuilder add(FormValidator<String> validator) {
    _validators.add(validator);
    return this;
  }

  /// Builds and returns a single validator function that combines all added validators.
  ///
  /// The returned function will run each validator in sequence until either:
  /// - A validation fails (returns an error message)
  /// - All validations pass (returns null)
  FormValidator<String> build() {
    return (value) {
      for (final validator in _validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// Validates that the field is not empty.
  ///
  /// [message] Optional custom error message builder.
  /// [allowWhitespace] If true, whitespace-only values are considered valid.
  ValidatorBuilder required([ValidationMessageBuilder? message, bool allowWhitespace = false]) {
    return add((value) {
      if (value == null || value.isEmpty || (!allowWhitespace && value.trim().isEmpty)) {
        return message?.call(value) ?? 'This field is required';
      }
      return null;
    });
  }

  /// Validates that the field contains a valid email address.
  ///
  /// [message] Optional custom error message builder.
  ValidatorBuilder email([ValidationMessageBuilder? message]) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (!_emailRegex.hasMatch(value)) {
        return message?.call(value) ?? 'Invalid email address';
      }
      return null;
    });
  }

  /// Validates that the field value has a minimum length.
  ///
  /// [length] The minimum allowed length.
  /// [message] Optional custom error message builder.
  ValidatorBuilder minLength(int length, [ValidationMessageBuilder? message]) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.length < length) {
        return message?.call(value) ?? 'Minimum length is $length characters';
      }
      return null;
    });
  }

  /// Validates that the field value has a maximum length.
  ///
  /// [length] The maximum allowed length.
  /// [message] Optional custom error message builder.
  ValidatorBuilder maxLength(int length, [ValidationMessageBuilder? message]) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.length > length) {
        return message?.call(value) ?? 'Maximum length is $length characters';
      }
      return null;
    });
  }

  /// Validates that the field value matches a specific pattern.
  ///
  /// [regex] The regular expression pattern to match.
  /// [message] Optional custom error message builder.
  ValidatorBuilder pattern(RegExp regex, [ValidationMessageBuilder? message]) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (!regex.hasMatch(value)) {
        return message?.call(value) ?? 'Invalid format';
      }
      return null;
    });
  }

  /// Validates that the field value is a valid phone number.
  ///
  /// Supports multiple phone number formats.
  /// [message] Optional custom error message builder.
  ValidatorBuilder phone([ValidationMessageBuilder? message]) {
    return pattern(_phoneRegex, message ?? ((value) => 'Invalid phone number'));
  }

  /// Validates that the field value is a number within a specified range.
  ///
  /// [min] Optional minimum value.
  /// [max] Optional maximum value.
  /// [message] Optional custom error message builder.
  ValidatorBuilder number({num? min, num? max, ValidationMessageBuilder? message}) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }

      final number = num.tryParse(value);
      if (number == null) {
        return message?.call(value) ?? 'Invalid number';
      }

      if (min != null && number < min) {
        return message?.call(value) ?? 'Number must be at least $min';
      }

      if (max != null && number > max) {
        return message?.call(value) ?? 'Number must be at most $max';
      }

      return null;
    });
  }

  /// Validates that the field value matches another value.
  ///
  /// Useful for password confirmation fields.
  /// [other] The value to match against.
  /// [message] Optional custom error message builder.
  ValidatorBuilder matches(String Function() other, [ValidationMessageBuilder? message]) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value != other()) {
        return message?.call(value) ?? 'Values do not match';
      }
      return null;
    });
  }

  /// Validates that the field value contains only letters.
  ///
  /// [message] Optional custom error message builder.
  ValidatorBuilder letters([ValidationMessageBuilder? message]) {
    return pattern(_lettersRegex, message ?? ((value) => 'Must contain only letters'));
  }

  /// Validates that the field value contains only numbers.
  ///
  /// [message] Optional custom error message builder.
  ValidatorBuilder digits([ValidationMessageBuilder? message]) {
    return pattern(_digitsRegex, message ?? ((value) => 'Must contain only digits'));
  }

  /// Validates that the field value is a valid URL.
  ///
  /// [message] Optional custom error message builder.
  ValidatorBuilder url([ValidationMessageBuilder? message]) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      final uri = Uri.tryParse(value);
      if (uri == null || (!uri.isAbsolute)) {
        return message?.call(value) ?? 'Invalid URL';
      }
      return null;
    });
  }

  /// Validates that the field value has no empty spaces.
  ///
  /// [message] Optional custom error message builder.
  ValidatorBuilder noEmptySpaces([ValidationMessageBuilder? message]) {
    return add((value) {
      if (value == null || value.isEmpty) {
        return null;
      }
      if (value.contains(' ')) {
        return message?.call(value) ?? 'Cannot contain empty spaces';
      }
      return null;
    });
  }
}
