require "rails_helper"

RSpec.describe IdeasController, type: :controller do
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  context "without signed in user" do
    describe "#new" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_sessions_path)
      end
    end

    context "with signed in user" do
      it "redirects to a new idea page" do
        session[:user_id] = current_user.id
        get :new
        expect(response).to(render_template(:new))
      end
    end
  end

  describe "#create" do
    def valid_request
      #   new_idea = Idea.new(title: "test Idea", body: "test body", user: FactoryBot.create(:user))
      post(:create, params: { idea: FactoryBot.attributes_for(:idea) })
    end

    context "without signed in user" do
      it "redirects the user to session new" do
        valid_request
        expect(response).to redirect_to(new_sessions_path)
      end
      it "sets a flash danger message" do
        valid_request
        expect(flash[:danger]).to be
      end
    end

    context "with signed in user" do
      before do
        session[:user_id] = current_user.id
      end

      context "with valid parameters" do
        it "creates a new idea post in the db" do
          count_before = Idea.count
          valid_request
          count_after = Idea.count
          expect(count_after).to eq(count_before + 1)
        end
      end

      it "redirects to the show page of that job post" do
        valid_request
        idea_post = Idea.last
        expect(response).to(redirect_to(idea_path(idea_post.id)))
      end
    end
  end
end
