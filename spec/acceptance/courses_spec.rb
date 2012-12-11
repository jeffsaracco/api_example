require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Courses" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:course) { Course.create(title: "my course", description: "this is a long course description")}
  let(:user) { User.create(email: "test@test.com", password: "password", password_confirmation: "password") }

  before do
    user.reset_authentication_token!
  end

  get "/courses" do
    parameter :auth_token, "The User authentication token"

    let(:auth_token) { user.authentication_token }

    before do
      2.times do |i|
        Course.create(:title => "Coruse #{i}", description: "course description #{i}")
      end
    end

    example_request "Getting a list of courses" do
      response_body.should == Course.all.to_json
      status.should == 200
    end
  end

  # post "/orders" do
    # parameter :name, "Name of order"
    # parameter :paid, "If the order has been paid for"
    # parameter :email, "Email of user that placed the order"

    # required_parameters :name, :paid

    # let(:name) { "Order 1" }
    # let(:paid) { true }
    # let(:email) { "email@example.com" }

    # let(:raw_post) { params.to_json }

    # scope_parameters :order, :all

    # example_request "Creating an order" do
      # explanation "First, create an order, then make a later request to get it back"
      # response_body.should be_json_eql({
        # "name" => name,
        # "paid" => paid,
        # "email" => email,
      # }.to_json)
      # status.should == 201

      # order = JSON.parse(response_body)

      # client.get(URI.parse(response_headers["location"]).path, {}, headers)
      # status.should == 200
    # end
  # end

  # get "/orders/:id" do
    # let(:id) { order.id }

    # example_request "Getting a specific order" do
      # response_body.should == order.to_json
      # status.should == 200
    # end
  # end

  # put "/orders/:id" do
    # parameter :name, "Name of order"
    # parameter :paid, "If the order has been paid for"
    # parameter :email, "Email of user that placed the order"
    # scope_parameters :order, :all

    # let(:id) { order.id }
    # let(:name) { "Updated Name" }

    # let(:raw_post) { params.to_json }

    # example_request "Updating an order" do
      # status.should == 200
    # end
  # end

  # delete "/orders/:id" do
    # let(:id) { order.id }

    # example_request "Deleting an order" do
      # status.should == 200
    # end
  # end
end
