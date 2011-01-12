module Confounded
  class FormBuilder < Formtastic::SemanticFormBuilder
    # Instead of multiple dropdowns to enter a date, we give the user
    # a simple text input. Via JavaScript we can add a calendar UI.
    def date_input(method, options)
      basic_input_helper(:text_field, :date, method, options)
    end
  end
end
