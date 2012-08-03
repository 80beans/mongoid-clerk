require 'spec_helper'

describe Clerk::Log do

  it { should be_timestamped_document }

  it { should have_field(:message) }
  it { should have_field(:level).of_type(Symbol) }

  it { should belong_to :logable }

end
