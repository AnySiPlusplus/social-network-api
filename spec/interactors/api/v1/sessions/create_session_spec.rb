RSpec.describe Api::V1::Sessions::CreateSession do
  subject(:result) { described_class.call(params:) }

  describe 'Success' do
    let!(:user) { create(:user) }
    let(:params) do
      {
        user: {
          login: user.login,
          password: user.password
        }
      }
    end

    it 'is create access token' do
      expect(result[:headers]).to include('Authorization')
    end

    it 'is result success' do
      expect(result).to be_success
    end
  end

  describe 'Fail' do
    let!(:user) { create(:user) }

    context 'when wrong login' do
      let(:params) do
        {
          user: {
            login: 'wrong',
            password: user.password
          }
        }
      end

      let(:error) { { login: I18n.t('session.errors.login') } }

      it 'is user not exist' do
        expect(result.message).to match error
      end
    end

    context 'when wrong login' do
      let(:params) do
        {
          user: {
            login: user.login,
            password: 'wrong'
          }
        }
      end
      let(:error) { { password: I18n.t('session.errors.password') } }

      it 'is user not exist' do
        expect(result.message).to match error
      end
    end
  end
end
