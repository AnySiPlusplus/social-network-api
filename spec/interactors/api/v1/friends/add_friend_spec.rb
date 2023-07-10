RSpec.describe Api::V1::Friends::AddFriend do
  subject(:result) { described_class.call(params:, current_user: user) }

  let!(:user) { create(:user) }

  describe 'Success' do
    let!(:friend_user) { create(:user) }
    let(:params) { { user_id: friend_user.id } }

    it 'is create message' do
      expect { result }.to change(Friend, :count).from(0).to(1)
    end

    it 'is result success' do
      expect(result).to be_success
    end
  end

  describe 'Wrong' do
    context 'when not found user' do
      let(:params) { { user_id: 0 } }

      it 'is result not success' do
        expect(result).not_to be_success
      end
    end
  end
end
