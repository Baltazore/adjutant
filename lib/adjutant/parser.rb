module Adjutant
  Parser = Struct.new(:json) do
    def repo_name
      @name ||=
        "#{json['repository']['owner']['name']}/#{json['repository']['name']}"
    end

    def commits_sha
      @shas ||= json['commits'].collect { |commit| commit['id'] }
    end
  end
end
