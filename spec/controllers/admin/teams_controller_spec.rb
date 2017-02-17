# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Admin::TeamsController do
  it_behaves_like 'admin only controller'

  include_context 'user is logged in' do
    describe 'DELETE #destroy' do
      context 'the team is empty' do
        let!(:team) { create :team }

        it 'deletes the team' do
          expect do
            delete :destroy, params: { id: team.id }
          end.to change(Team, :count).by(-1)
        end

        it 'sets a nice flash message' do
          delete :destroy, params: { id: team.id }
          expect(controller).to set_flash[:notice].to 'Team was successfully destroyed.'
        end

        it 'redirects to the admin teams index' do
          expect(delete(:destroy, params: { id: team.id })).
            to redirect_to admin_teams_path
        end
      end

      context 'there are still members assigned to that team' do
        let!(:team) { create :team }
        let!(:member_profile) { create :member_profile, team: team }

        it 'does not raise an invalid key error' do
          expect do
            delete :destroy, params: { id: team.id }
          end.not_to raise_error
        end

        it 'does not delete the team' do
          expect do
            delete :destroy, params: { id: team.id }
          end.not_to change(Team, :count)
        end

        it 'sets a warning message' do
          delete :destroy, params: { id: team.id }
          expect(controller).to set_flash[:alert].
            to 'Team still has members. Please remove all the team members before deleting a team.'
        end

        it 'redirects to the teams index' do
          expect(delete(:destroy, params: { id: team.id })).
            to redirect_to admin_teams_path
        end
      end
    end
  end
end
