class Brat::Client
  # Defines methods related to issues.
  module Issues
    # Gets a list of user's issues.
    # Will return a list of project's issues if project ID passed.
    #
    # @example
    #   Brat.issues
    #   Brat.issues(5)
    #   Brat.issues(:per_page => 40)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def issues(project=nil, options={})
      if project.to_i.zero?
        get("/issues", :query => options)
      else
        get("/projects/#{project}/issues", :query => options)
      end
    end

    # Gets a single issue.
    #
    # @example
    #   Brat.issue(5, 42)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of an issue.
    # @return [Brat::ObjectifiedHash]
    def issue(project, id)
      get("/projects/#{project}/issues/#{id}")
    end

    # Creates a new issue.
    #
    # @param  [Integer] project The ID of a project.
    # @param  [String] title The title of an issue.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :description The description of an issue.
    # @option options [Integer] :assignee_id The ID of a user to assign issue.
    # @option options [Integer] :milestone_id The ID of a milestone to assign issue.
    # @option options [String] :labels Comma-separated label names for an issue.
    # @return [Brat::ObjectifiedHash] Information about created issue.
    def create_issue(project, title, options={})
      body = {:title => title}.merge(options)
      post("/projects/#{project}/issues", :body => body)
    end

    # Updates an issue.
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of an issue.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :title The title of an issue.
    # @option options [String] :description The description of an issue.
    # @option options [Integer] :assignee_id The ID of a user to assign issue.
    # @option options [Integer] :milestone_id The ID of a milestone to assign issue.
    # @option options [String] :labels Comma-separated label names for an issue.
    # @option options [String] :state_event The state event of an issue ('close' or 'reopen').
    # @return [Brat::ObjectifiedHash] Information about updated issue.
    def edit_issue(project, id, options={})
      put("/projects/#{project}/issues/#{id}", :body => options)
    end

    # Closes an issue.
    #
    # @example
    #   Brat.close_issue(3, 42)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of an issue.
    # @return [Brat::ObjectifiedHash] Information about closed issue.
    def close_issue(project, id)
      put("/projects/#{project}/issues/#{id}", :body => {:state_event => 'close'})
    end

    # Reopens an issue.
    #
    # @example
    #   Brat.reopen_issue(3, 42)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of an issue.
    # @return [Brat::ObjectifiedHash] Information about reopened issue.
    def reopen_issue(project, id)
      put("/projects/#{project}/issues/#{id}", :body => {:state_event => 'reopen'})
    end
  end
end
