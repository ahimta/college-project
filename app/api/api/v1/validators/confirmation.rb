class API::V1::Validators::Confirmation < Grape::Validations::SingleOptionValidator
  def validate_param!(attr_name, params)
    unless params[attr_name] == params[@option]
      raise Grape::Exceptions::Validation, param: @scope.full_name(attr_name), message: "#{attr_name} must equal #{@option}"
    end
  end
end
