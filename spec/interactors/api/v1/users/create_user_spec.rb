RSpec.describe Api::V1::Users::CreateUser do
  subject(:result) { described_class.call(params:) }

  let(:valid_params) { attributes_for(:user) }
  let(:params) { {} }

  describe 'Success' do
    let(:params) { ActionController::Parameters.new(user: valid_params) }

    it 'is create user' do
      expect { result }.to change(User, :count).from(0).to(1)
    end

    it 'is create user and login eql login params' do
      expect(result.form.login).to eq(params[:user][:login])
    end

    it 'shoul be model be persisted' do
      expect(result.form).to be_persisted
    end

    it 'shoul be model instanse of User' do
      expect(result.form).to an_instance_of User
    end

    it 'is result success' do
      expect(result).to be_success
    end
  end

  describe 'Fail' do
    context 'with invalid password' do
      let(:params) do
        ActionController::Parameters.new(user: valid_params.merge(password: 'pas sword',
                                                                  password_confirmation: 'pas sword'))
      end
      let(:errors) do
        {
          password: [I18n.t('user.errors.password')]
        }
      end

      it { expect(result).to be_failure }

      it 'has validation errors' do
        expect(result.message).to match errors
      end
    end

    context 'with unconfirmed password' do
      let(:params) { ActionController::Parameters.new(user: valid_params.merge(password_confirmation: 'no')) }
      let(:errors) { { password_confirmation: [I18n.t('user.errors.password_confirmation')] } }

      it { expect(result).to be_failure }

      it 'has validation errors' do
        expect(result.message).to match errors
      end
    end

    context 'with non unique login' do
      let!(:user) { create(:user) }
      let(:params) { ActionController::Parameters.new(user: valid_params.merge(login: user.login)) }

      let(:errors) { { login: [I18n.t('user.errors.login')] } }

      it { expect(result).to be_failure }

      it 'has validation errors' do
        expect(result.message).to match errors
      end
    end
  end
end
