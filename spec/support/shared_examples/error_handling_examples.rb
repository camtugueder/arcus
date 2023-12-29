RSpec.shared_examples 'standard error handling' do |path|
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
  end


  it 'handles ActiveRecord::RecordNotFound' do
    allow_any_instance_of(described_class).to receive(:index).and_raise(ActiveRecord::RecordNotFound)
    get path
    expect(response).to have_http_status(:not_found)
  end

  it 'handles Pundit::NotAuthorizedError' do
    allow_any_instance_of(described_class).to receive(:index).and_raise(Pundit::NotAuthorizedError)
    get path
    expect(response).to have_http_status(:forbidden)
  end

  it 'handles StandardError' do
    allow_any_instance_of(described_class).to receive(:index).and_raise(StandardError)
    get path
    expect(response).to have_http_status(:internal_server_error)
  end
end
