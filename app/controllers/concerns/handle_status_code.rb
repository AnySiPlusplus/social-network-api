module HandleStatusCode
  def default_handler(result)
    success_response(result) if result.status == :created
    success_response(result) if result.status == :ok
    invalid_response(result) unless result.success?

    # {
    #   no_content: ->(result) { result.success? && model_not_exist?(result) },
    #   forbidden: ->(result) { result['result.status'] == :forbidden },
    #   not_found: ->(result) { result[:model].nil? && result.failure? }
    # }
  end

  private

  def success_response(result)
    response.headers.merge!(result.headers) if result.headers.present?
    render json: [result.serializer&.new(result.form), { message: result.success_message }],
           status: result.status
  end

  def invalid_response(result)
    render json: { errors: result.message }, status: :unprocessable_entity
  end
end
