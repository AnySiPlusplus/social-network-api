RSpec.describe Message, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:text) }
    it { is_expected.to have_db_column(:file_data) }
    it { is_expected.to have_db_column(:to_whom) }
  end
end
