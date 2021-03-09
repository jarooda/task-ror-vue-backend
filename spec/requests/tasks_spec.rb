require "rails_helper"
require "date"

RSpec.describe "Tasks testing", :type => :request do
  
  it "success GET /tasks" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }

    get "/api/v1/tasks", headers: { "Authorization": "Bearer #{json["token"]}"}

    expect(response).to have_http_status(:success)
  end

  it "failure GET /tasks because token is wrong" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }

    get "/api/v1/tasks", headers: { "Authorization": "Bearer Somehardcodedtoken" }

    expect(response).to have_http_status(:unauthorized)
    expect(json["message"]).to eq("Please log in")
  end

  it "success POST /tasks" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }
    user = json

    post "/api/v1/tasks", params: { task: { title: "TASK 1", description: "DESCRIPTION 1", priorities: "High", due_date: Date.today, status: false } } ,headers: { "Authorization": "Bearer #{user['token']}" }

    expect(response).to have_http_status(:success)
    expect(json["title"]).to eq("TASK 1") 
  end

  it "failure POST /tasks because token is wrong" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }

    post "/api/v1/tasks", params: { task: { title: "TASK 1", description: "DESCRIPTION 1", priorities: "High", due_date: Date.today, status: false } }, headers: { "Authorization": "Bearer Somehardcodedtoken" }

    expect(response).to have_http_status(:unauthorized)
    expect(json["message"]).to eq("Please log in")
  end

  it "success PUT /tasks" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }
    user = json

    post "/api/v1/tasks", params: { task: { title: "TASK 1", description: "DESCRIPTION 1", priorities: "High", due_date: Date.today, status: false } } ,headers: { "Authorization": "Bearer #{user['token']}" }
    task = json

    put "/api/v1/tasks/#{task['id']}", params: { task: { title: "TASK change", description: "DESCRIPTION change", priorities: "Low", due_date: Date.today, status: false } },headers: { "Authorization": "Bearer #{user['token']}" }

    expect(response).to have_http_status(:success)
    expect(json["title"]).to eq("TASK change") 
  end

  it "failure PUT /tasks because not authorized to edit another user task" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }
    user1 = json

    FactoryBot.create(:user, email: "jalu@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "jalu@mail.com", password: "cobarspec" }
    user2 = json

    post "/api/v1/tasks", params: { task: { title: "TASK 1", description: "DESCRIPTION 1", priorities: "High", due_date: Date.today, status: false } } ,headers: { "Authorization": "Bearer #{user1['token']}" }
    task = json

    put "/api/v1/tasks/#{task['id']}", params: { task: { title: "TASK change", description: "DESCRIPTION change", priorities: "Low", due_date: Date.today, status: false } },headers: { "Authorization": "Bearer #{user2['token']}" }

    expect(response).to have_http_status(:unauthorized)
    expect(json["message"]).to eq("Not authorized.") 
  end  

  it "success PATCH /tasks" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }
    user = json

    post "/api/v1/tasks", params: { task: { title: "TASK 1", description: "DESCRIPTION 1", priorities: "High", due_date: Date.today, status: false } } ,headers: { "Authorization": "Bearer #{user['token']}" }
    task = json

    patch "/api/v1/tasks/#{task['id']}", params: { task: { status: false } },headers: { "Authorization": "Bearer #{user['token']}" }

    expect(response).to have_http_status(:success)
    expect(json["title"]).to eq("TASK 1") 
    expect(json["status"]).to eq(false) 
  end

  it "success DELETE /tasks" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")
    
    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }
    user = json

    post "/api/v1/tasks", params: { task: { title: "TASK 1", description: "DESCRIPTION 1", priorities: "High", due_date: Date.today, status: false } } ,headers: { "Authorization": "Bearer #{user['token']}" }
    task = json

    delete "/api/v1/tasks/#{task['id']}", headers: { "Authorization": "Bearer #{user['token']}" }

    expect(response).to have_http_status(:success)
    expect(json["message"]).to eq("Task deleted.")
  end

end