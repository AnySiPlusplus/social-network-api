RSpec.describe User, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:login).with_options(null: false) }
    it { is_expected.to have_db_column(:password_digest).with_options(null: false) }
  end
end
