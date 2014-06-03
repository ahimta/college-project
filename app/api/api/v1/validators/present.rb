class API::V1::Validators::Present < Grape::Validations::Validator
  def validate_param!(attr_name, params)
    unless params[attr_name].present?
      raise(Grape::Exceptions::Validation, param: @scope.full_name(attr_name),
        message: "can't be blank")
    end
  end
end
