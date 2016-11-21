require 'rails_helper'

RSpec.describe TeamMember, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to delegate_method(:name).to(:user) }

  describe 'slugging' do
    it 'handles slugging team members when slugs are taken' do
      user = create :user, first_name: 'A', last_name: 'User'
      team_member = create :team_member, user: user

      expect(team_member.slug).to eq 'a-user'

      other_user = create :user, first_name: 'A', last_name: 'User'
      other_team_member = create :team_member, user: other_user, position: 'marketing'

      expect(other_team_member.slug).to eq 'a-user-marketing'
    end
  end
end
