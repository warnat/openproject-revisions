module OpenProject::Revisions
  class ProxiedRepositoryHook < Redmine::Hook::Listener
    @@delegates = []

    def self.delegate(klass)
        @@delegates.push(klass.new)
    end

    def method_missing(method, *args, &block)
      delegates_for(method).each do |delegate|
        if delegate.accepts?(method, *args)
          delegate.send(method, *args, &block)
        end
      end
    end

    def respond_to?(method)
      delegates_for(method).size > 0
    end

    def delegates_for(method)
      @@delegates.select {|d| d.respond_to?(method) }
    end
  end
end