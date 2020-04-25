# frozen_string_literal: true

module ErrorsSerializer
  def response_validation_errors(resource)
    {
      errors: { detail: resource.errors }
    }
  end
end
