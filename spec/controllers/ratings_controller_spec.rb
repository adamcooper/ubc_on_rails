require 'spec_helper'


describe RatingsController do

  # This should return the minimal set of attributes required to create a valid
  # Rating. As you add validations to Rating, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {name: "Name", comments: "Comments"}
  end

  describe "GET index" do
    it "assigns all ratings as @ratings" do
      rating = Rating.create! valid_attributes
      get :index
      assigns(:ratings).should eq([rating])
    end
  end

  describe "GET show" do
    it "assigns the requested rating as @rating" do
      rating = Rating.create! valid_attributes
      get :show, :id => rating.id
      assigns(:rating).should eq(rating)
    end
  end

  describe "GET new" do
    it "assigns a new rating as @rating" do
      get :new
      assigns(:rating).should be_a_new(Rating)
    end
  end

  describe "GET edit" do
    it "assigns the requested rating as @rating" do
      rating = Rating.create! valid_attributes
      get :edit, :id => rating.id
      assigns(:rating).should eq(rating)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Rating" do
        expect {
          post :create, :rating => valid_attributes
        }.to change(Rating, :count).by(1)
      end

      it "assigns a newly created rating as @rating" do
        post :create, :rating => valid_attributes
        assigns(:rating).should be_a(Rating)
        assigns(:rating).should be_persisted
      end

      it "redirects to the created rating" do
        post :create, :rating => valid_attributes
        response.should redirect_to(Rating.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rating as @rating" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rating.any_instance.stub(:save).and_return(false)
        post :create, :rating => {}
        assigns(:rating).should be_a_new(Rating)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rating.any_instance.stub(:save).and_return(false)
        post :create, :rating => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rating" do
        rating = Rating.create! valid_attributes
        # Assuming there are no other ratings in the database, this
        # specifies that the Rating created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Rating.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => rating.id, :rating => {'these' => 'params'}
      end

      it "assigns the requested rating as @rating" do
        rating = Rating.create! valid_attributes
        put :update, :id => rating.id, :rating => valid_attributes
        assigns(:rating).should eq(rating)
      end

      it "redirects to the rating" do
        rating = Rating.create! valid_attributes
        put :update, :id => rating.id, :rating => valid_attributes
        response.should redirect_to(rating)
      end
    end

    describe "with invalid params" do
      it "assigns the rating as @rating" do
        rating = Rating.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rating.any_instance.stub(:save).and_return(false)
        put :update, :id => rating.id, :rating => {}
        assigns(:rating).should eq(rating)
      end

      it "re-renders the 'edit' template" do
        rating = Rating.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rating.any_instance.stub(:save).and_return(false)
        put :update, :id => rating.id, :rating => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested rating" do
      rating = Rating.create! valid_attributes
      expect {
        delete :destroy, :id => rating.id
      }.to change(Rating, :count).by(-1)
    end

    it "redirects to the ratings list" do
      rating = Rating.create! valid_attributes
      delete :destroy, :id => rating.id
      response.should redirect_to(ratings_url)
    end
  end

end
