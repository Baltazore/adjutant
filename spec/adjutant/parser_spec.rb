require 'spec_helper'

RSpec.describe Adjutant::Parser do

  let(:json) do
    {
      "repository" => {
        "owner" => { "name" => 'Baltazore' },
        "name"  => "adjutant",
      },
      "commits" => [ { "id" => "asda" }, {"id" => "asds" } ],
      "pusher" => { "name" => "Baltazore" },
    }
  end
  let(:parser) { Adjutant::Parser.new(json) }

  it 'gets commits sha' do
    expect(parser.commits_sha).to eq(['asda', 'asds'])
  end

  it 'fetches repo name' do
    expect(parser.repo_name).to eq('Baltazore/adjutant')
  end

  it 'gets commiter nickname' do
    expect(parser.commiter_nickname).to eq('Baltazore')
  end
end
