RSpec.describe Api::V1::Messages::CreateMessage do
  subject(:result) { described_class.call(params:, current_user: user) }

  let!(:user) { create(:user) }
  let(:valid_params) { attributes_for(:message).except(:user) }
  let(:params) { {} }

  describe 'Success' do
    let(:params) { ActionController::Parameters.new(message: valid_params) }

    it 'is create message' do
      expect { result }.to change(Message, :count).from(0).to(1)
    end

    it 'is create message eql message params' do
      expect(result.form.text).to eq(params[:message][:text])
    end

    it 'shoul be model be persisted' do
      expect(result.form).to be_persisted
    end

    it 'shoul be model instanse of Message' do
      expect(result.form).to an_instance_of Message
    end

    it 'is result success' do
      expect(result).to be_success
    end
  end

  describe 'Wrong params' do
    let(:params) { ActionController::Parameters.new(message: { text: nil, file: nil, to_whom: user.id }) }

    it 'is not created user' do
      expect { result }.not_to(change(Message, :count))
    end
  end
end
