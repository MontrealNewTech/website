require "rails_helper"

RSpec.describe InitiativesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/initiatives").to route_to("initiatives#index")
    end

    it "routes to #new" do
      expect(:get => "/initiatives/new").to route_to("initiatives#new")
    end

    it "routes to #show" do
      expect(:get => "/initiatives/1").to route_to("initiatives#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/initiatives/1/edit").to route_to("initiatives#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/initiatives").to route_to("initiatives#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/initiatives/1").to route_to("initiatives#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/initiatives/1").to route_to("initiatives#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/initiatives/1").to route_to("initiatives#destroy", :id => "1")
    end

  end
end
