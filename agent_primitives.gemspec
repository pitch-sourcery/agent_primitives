# frozen_string_literal: true

require_relative "lib/agent_primitives/version"

Gem::Specification.new do |spec|
  spec.name = "agent_primitives"
  spec.version = AgentPrimitives::VERSION
  spec.authors = [ "Chris Bellairs" ]
  spec.email = [ "chris@pitchd.ai" ]

  spec.summary = "Durable intent for coding agents — capability docs proven by tagged specs."
  spec.description = <<~TEXT.gsub("\n", " ").strip
    Checks that every intent clause in an app's docs/primitives/ tree is proven
    by a tagged RSpec example, reports what a change did to that record, and
    imports the skills that teach a coding agent to keep it.
  TEXT

  spec.homepage = "https://github.com/pitch-sourcery/agent_primitives"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # The reject mirrors AgentPrimitives::DEV_ONLY, which `import` reads. Literal
  # because a gemspec should not load the library it packages; spec/gem_spec.rb
  # asserts the two agree.
  spec.files = Dir.chdir(__dir__) do
    skills = Dir.glob("skills/**/*").select { |path| File.file?(path) }
                .reject { |path| path.start_with?("skills/maintaining-agent-primitives/") }

    skills + Dir.glob("lib/**/*.rb") +
      [ "exe/agent_primitives", "LICENSE", "README.md", "CHANGELOG.md" ].select { |f| File.exist?(f) }
  end

  spec.bindir = "exe"
  spec.executables = [ "agent_primitives" ]
  spec.require_paths = [ "lib" ]
end
