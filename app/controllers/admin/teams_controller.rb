module Admin
  class TeamsController < Admin::ApplicationController
    def destroy
      team = Team.find(params[:id])
      return could_not_delete(team) if still_has_member_profiles?(team)
      super
    end

    private

    def could_not_delete(team)
      flash[:alert] = 'Team still has members. Please remove all the team members before deleting a team.'
      redirect_to admin_teams_path
    end

    def still_has_member_profiles?(team)
      !team.member_profiles.empty?
    end
  end
end
