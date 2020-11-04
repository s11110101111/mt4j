#property copyright "Copyright © 2006-2017"
#property version "1.12"
#property strict

class InputsBuilder
  {

   string            inputs;

   bool              is_builed;

   string            _empty_inputs;

   string            _array_next_item_formatter;

   string            _input_string_formatter;

   string            _input_double_formatter;

   string            _input_long_formatter;

   string            _array_formatter;

public:
                     InputsBuilder()
     {
      inputs = "";
      is_builed = false;
      _empty_inputs = "[]";
      _array_formatter = "[%s]";
      _array_next_item_formatter = "%s%s, ";
      _input_long_formatter = "{ \"key\": %s, \"value\": %d }";
      _input_string_formatter = "{ \"key\": %s, \"value\": %s }";
      _input_double_formatter = "{ \"key\": %s, \"value\": %G }";
     }
                    ~InputsBuilder() {}

public:

   string             Build()
     {
      if(inputs == "")
        {
         Alert("Warning! Inputs is empty.");
         return _empty_inputs;
        }

      string json = StringSubstr(inputs, 0, StringLen(inputs) - 1);
      inputs = StringFormat(_array_formatter, json);
      is_builed = true;
      return inputs;
     }

   string             GetInputs()
     {
      if(is_builed)
        {
         Alert("Build() wasn't called. Method Build() should be called before GetInputs().");
         return _empty_inputs;
        }
      return inputs;
     }

   void              InputString(string key, string value)
     {
      if(is_builed)
        {
         Alert("Build() already done. Method Build() can be called only once.");
         return;
        }
      string input_string = StringFormat(_input_string_formatter, key, value);
      inputs = StringFormat(_array_next_item_formatter, inputs, input_string);
     }

   void              InputDouble(string key, double value)
     {
      if(is_builed)
        {
         Alert("Build() already done. Method Build() can be called only once.");
         return;
        }
      string input_double = StringFormat(_input_double_formatter, key, value);
      inputs = StringFormat(_array_next_item_formatter, inputs, input_double);
     }

   void              InputLong(string key, long value)
     {
      if(is_builed)
        {
         Alert("Build() already done. Method Build() can be called only once.");
         return;
        }
      string input_long = StringFormat(_input_long_formatter, key, value);
      inputs = StringFormat(_array_next_item_formatter, inputs, input_long);
     }

   void              InputInteger(string key, int value)
     {
      InputLong(key, (long) value);
     }

   void              InputDatetime(string key, datetime value)
     {
      InputLong(key, ((long) value) * 1000);
     }

   void              InputTimeSeconds(string key, int value)
     {
      InputLong(key, ((long) value) * 1000);
     }

   void              InputTimeMilliseconds(string key, long value)
     {
      InputLong(key, value);
     }

  };