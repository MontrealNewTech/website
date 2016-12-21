# frozen_string_literal: true
class TeamMembersController < ApplicationController
  def index
    @team_members = TeamMember.all
  end
end
