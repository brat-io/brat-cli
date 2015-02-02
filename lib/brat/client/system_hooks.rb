class Brat::Client
  # Defines methods related to system hooks.
  module SystemHooks
    # Gets a list of system hooks.
    #
    # @example
    #   Brat.hooks
    #   Brat.system_hooks
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def hooks(options={})
      get("/hooks", query: options)
    end
    alias_method :system_hooks, :hooks

    # Adds a new system hook.
    #
    # @example
    #   Brat.add_hook('http://example.com/hook')
    #   Brat.add_system_hook('https://api.example.net/v1/hook')
    #
    # @param  [String] url The hook URL.
    # @return [Brat::ObjectifiedHash]
    def add_hook(url)
      post("/hooks", :body => {:url => url})
    end
    alias_method :add_system_hook, :add_hook

    # Tests a system hook.
    #
    # @example
    #   Brat.hook(3)
    #   Brat.system_hook(12)
    #
    # @param  [Integer] id The ID of a system hook.
    # @return [Array<Brat::ObjectifiedHash>]
    def hook(id)
      get("/hooks/#{id}")
    end
    alias_method :system_hook, :hook

    # Deletes a new system hook.
    #
    # @example
    #   Brat.delete_hook(3)
    #   Brat.delete_system_hook(12)
    #
    # @param  [Integer] id The ID of a system hook.
    # @return [Brat::ObjectifiedHash]
    def delete_hook(id)
      delete("/hooks/#{id}")
    end
    alias_method :delete_system_hook, :delete_hook
  end
end
