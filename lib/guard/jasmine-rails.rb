require 'guard'
require 'guard/plugin'
require 'guard/watcher'

module Guard
  class JasmineRails < Plugin
    DEFAULTS = {
      all_on_start: true
    }
    LOG_PREFIX = 'Guard::JasmineRails'
    NOTIFICATION_TITLE = 'Jasmine results'

    def initialize(options = {})
      super DEFAULTS.merge(options)
    end

    def start
      log 'is now running'
      run_all if options[:all_on_start]
    end

    def run_all
      spec_filter = nil
      run spec_filter
    end

    # run jasmine specs for only the changed files
    # if the changed file does not contain a jasmine describe block,
    # re-run the entire jasmine test suite
    def run_on_changes(paths)
      spec_filters = paths.collect {|path| spec_description(path) }.uniq
      spec_filters = [nil] if spec_filters.include?(nil)
      spec_filters.each do |spec_filter|
        run spec_filter
      end
    end

    private

    # parse the outermost describe block from a Jasmine spec file
    # returns nil if no describe block is found
    def spec_description(path)
      File.read(path).scan(/describe.+?['"]([^'"]+)/).flatten.first
    end

    def run(spec_filter = nil)
      message = 'Running Jasmine specs'
      message += " with filter: #{spec_filter}" if spec_filter
      log message

      command = "bundle exec rake spec:javascript RAILS_ENV=test"
      command += " SPEC=#{spec_filter}" if spec_filter
      log "Running: #{command}", :debug
      success = system(command)
      if success
        log 'No failures detected'
        notify 'All specs passed.', :success
      else
        log "Error running specs", :error
        notify 'Error running specs.', :failed
      end
    end

    def log(message, level = :info)
      UI.send(level, [LOG_PREFIX, message].join(' '))
    end

    def notify(message, type = :success)
      priority = {
        failed:   2,
        success: -2
      }[type]
      ::Guard::Notifier.notify(message, title: NOTIFICATION_TITLE , image: type, priority: priority)
    end
  end
end
