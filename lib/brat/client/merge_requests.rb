class Brat::Client
  # Defines methods related to merge requests.
  module MergeRequests
    # Gets a list of project merge requests.
    #
    # @example
    #   Brat.merge_requests(5)
    #   Brat.merge_requests(:per_page => 40)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def merge_requests(project, options={})
      get("/projects/#{project}/merge_requests", :query => options)
    end

    # Gets a single merge request.
    #
    # @example
    #   Brat.merge_request(5, 36)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of a merge request.
    # @return <Brat::ObjectifiedHash]
    def merge_request(project, id)
      get("/projects/#{project}/merge_request/#{id}")
    end

    # Creates a merge request.
    #
    # @example
    #   Brat.create_merge_request(5, 'New merge request',
    #     :source_branch => 'source_branch', :target_branch => 'target_branch')
    #   Brat.create_merge_request(5, 'New merge request',
    #     :source_branch => 'source_branch', :target_branch => 'target_branch', :assignee_id => 42)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [String] title The title of a merge request.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :source_branch (required) The source branch name.
    # @option options [String] :target_branch (required) The target branch name.
    # @option options [Integer] :assignee_id (optional) The ID of a user to assign merge request.
    # @return [Brat::ObjectifiedHash] Information about created merge request.
    def create_merge_request(project, title, options={})
      check_attributes!(options, [:source_branch, :target_branch])

      body = {:title => title}.merge(options)
      post("/projects/#{project}/merge_requests", :body => body)
    end

    # Updates a merge request.
    #
    # @example
    #   Brat.update_merge_request(5, 42, :title => 'New title')
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of a merge request.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :title The title of a merge request.
    # @option options [String] :source_branch The source branch name.
    # @option options [String] :target_branch The target branch name.
    # @option options [Integer] :assignee_id The ID of a user to assign merge request.
    # @option options [String] :state_event New state (close|reopen|merge).
    # @return [Brat::ObjectifiedHash] Information about updated merge request.
    def update_merge_request(project, id, options={})
      put("/projects/#{project}/merge_request/#{id}", :body => options)
    end

    # Adds a comment to a merge request.
    #
    # @example
    #   Brat.create_merge_request_comment(5, 1, "Awesome merge!")
    #   Brat.create_merge_request_comment('brat', 1, "Awesome merge!")
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of a merge request.
    # @param  [String] note The content of a comment.
    # @return [Brat::ObjectifiedHash] Information about created merge request comment.
    def create_merge_request_comment(project, id, note)
      post("/projects/#{project}/merge_request/#{id}/comments", :body => {:note => note})
    end

    # Gets the comments on a merge request.
    #
    # @example
    #   Brat.merge_request_comments(5, 1)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of a merge request.
    # @return [Brat::ObjectifiedHash] The merge request's comments.
    def merge_request_comments(project, id)
      get("/projects/#{project}/merge_request/#{id}/comments")
    end

    private

    def check_attributes!(options, attrs)
      attrs.each do |attr|
        unless options.has_key?(attr) || options.has_key?(attr.to_s)
          raise Brat::Error::MissingAttributes.new("Missing '#{attr}' parameter")
        end
      end
    end
  end
end
