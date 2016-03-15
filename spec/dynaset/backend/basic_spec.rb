require 'dynaset/backend/basic'

describe Dynamic::Backend::BasicBackend.new do
  it { should respond_to(:set!) }
  it { should respond_to(:journal) }
  it { should respond_to(:get!) }
  it { should respond_to(:watch) }
end

describe Dynamic::Backend::BasicBackend::Journal.new do
  it { should respond_to :set! }
  it { should respond_to :get! }
end
