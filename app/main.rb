# frozen_string_literal: true

require_relative 'boot'

Cli::Runner.execute($stdin, $stdout)
