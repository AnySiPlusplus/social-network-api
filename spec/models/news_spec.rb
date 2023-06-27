RSpec.describe News, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:content) }
    it { is_expected.to have_db_column(:file_data) }
  end
end
