module HandleStatusCode
  def default_handler(result)
    success_response(result) if result.status == :created
    success_response(result) if result.status == :ok
    no_content_response if result.status == :no_content
    forbidden_response(result) if status == :forbidden
    invalid_response(result) unless result.success?
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

  def no_content_response
    render json: {}, status: :no_content
  end

  # def forbidden_response(result)
  #   render json: { message: result.message }, status: result.status
  # end
end
