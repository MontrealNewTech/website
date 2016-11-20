require "rails_helper"

RSpec.describe TeamMembersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/team_members").to route_to("team_members#index")
    end

    it "routes to #new" do
      expect(:get => "/team_members/new").to route_to("team_members#new")
    end

    it "routes to #show" do
      expect(:get => "/team_members/1").to route_to("team_members#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/team_members/1/edit").to route_to("team_members#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/team_members").to route_to("team_members#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/team_members/1").to route_to("team_members#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/team_members/1").to route_to("team_members#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/team_members/1").to route_to("team_members#destroy", :id => "1")
    end

  end
end
