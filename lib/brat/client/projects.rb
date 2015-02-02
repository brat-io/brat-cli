class Brat::Client
  # Defines methods related to projects.
  module Projects
    # Gets a list of projects owned by the authenticated user.
    #
    # @example
    #   Brat.projects
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @option options [String] :scope Scope of projects. 'owned' for list of projects owned by the authenticated user, 'all' to get all projects (admin only)
    # @return [Array<Brat::ObjectifiedHash>]
    def projects(options={})
      if (options[:scope])
        get("/projects/#{options[:scope]}", :query => options)
      else
        get("/projects", :query => options)
      end
    end

    # Gets information about a project.
    #
    # @example
    #   Brat.project(3)
    #   Brat.project('brat')
    #
    # @param  [Integer, String] id The ID or name of a project.
    # @return [Brat::ObjectifiedHash]
    def project(id)
      get("/projects/#{id}")
    end

    # Gets a list of project events.
    #
    # @example
    #   Brat.project_events(42)
    #   Brat.project_events('brat')
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def project_events(project, options={})
      get("/projects/#{project}/events", :query => options)
    end

    # Creates a new project.
    #
    # @example
    #   Brat.create_project('brat')
    #   Brat.create_project('viking', :description => 'Awesome project')
    #   Brat.create_project('Red', :wall_enabled => false)
    #
    # @param  [String] name The name of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :description The description of a project.
    # @option options [String] :default_branch The default branch of a project.
    # @option options [Boolean] :wiki_enabled The wiki integration for a project (0 = false, 1 = true).
    # @option options [Boolean] :wall_enabled The wall functionality for a project (0 = false, 1 = true).
    # @option options [Boolean] :issues_enabled The issues integration for a project (0 = false, 1 = true).
    # @option options [Boolean] :snippets_enabled The snippets integration for a project (0 = false, 1 = true).
    # @option options [Boolean] :merge_requests_enabled The merge requests functionality for a project (0 = false, 1 = true).
    # @option options [Boolean] :public The setting for making a project public (0 = false, 1 = true).
    # @option options [Integer] :user_id The user/owner id of a project.
    # @return [Brat::ObjectifiedHash] Information about created project.
    def create_project(name, options={})
      url = options[:user_id] ? "/projects/user/#{options[:user_id]}" : "/projects"
      post(url, :body => {:name => name}.merge(options))
    end

    # Deletes a project.
    #
    # @example
    #   Brat.delete_project(4)
    #
    # @param  [Integer, String] id The ID or name of a project.
    # @return [Brat::ObjectifiedHash] Information about deleted project.
    def delete_project(id)
      delete("/projects/#{id}")
    end

    # Gets a list of project team members.
    #
    # @example
    #   Brat.team_members(42)
    #   Brat.team_members('brat')
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :query The search query.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def team_members(project, options={})
      get("/projects/#{project}/members", :query => options)
    end

    # Gets a project team member.
    #
    # @example
    #   Brat.team_member('brat', 2)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a project team member.
    # @return [Brat::ObjectifiedHash]
    def team_member(project, id)
      get("/projects/#{project}/members/#{id}")
    end

    # Adds a user to project team.
    #
    # @example
    #   Brat.add_team_member('brat', 2, 40)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a user.
    # @param  [Integer] access_level The access level to project.
    # @param  [Hash] options A customizable set of options.
    # @return [Brat::ObjectifiedHash] Information about added team member.
    def add_team_member(project, id, access_level)
      post("/projects/#{project}/members", :body => {:user_id => id, :access_level => access_level})
    end

    # Updates a team member's project access level.
    #
    # @example
    #   Brat.edit_team_member('brat', 3, 20)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a user.
    # @param  [Integer] access_level The access level to project.
    # @param  [Hash] options A customizable set of options.
    # @return [Array<Brat::ObjectifiedHash>] Information about updated team member.
    def edit_team_member(project, id, access_level)
      put("/projects/#{project}/members/#{id}", :body => {:access_level => access_level})
    end

    # Removes a user from project team.
    #
    # @example
    #   Brat.remove_team_member('brat', 2)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a user.
    # @param  [Hash] options A customizable set of options.
    # @return [Brat::ObjectifiedHash] Information about removed team member.
    def remove_team_member(project, id)
      delete("/projects/#{project}/members/#{id}")
    end

    # Gets a list of project hooks.
    #
    # @example
    #   Brat.project_hooks(42)
    #   Brat.project_hooks('brat')
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def project_hooks(project, options={})
      get("/projects/#{project}/hooks", :query => options)
    end

    # Gets a project hook.
    #
    # @example
    #   Brat.project_hook(42, 5)
    #   Brat.project_hook('brat', 5)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of a hook.
    # @return [Brat::ObjectifiedHash]
    def project_hook(project, id)
      get("/projects/#{project}/hooks/#{id}")
    end

    # Adds a new hook to the project.
    #
    # @example
    #   Brat.add_project_hook(42, 'https://api.example.net/v1/webhooks/ci')
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [String] url The hook URL.
    # @param  [Hash] options Events list (`{push_events: true, merge_requests_events: false}`).
    # @return [Brat::ObjectifiedHash] Information about added hook.
    def add_project_hook(project, url, options = {})
      available_events = [:push_events, :merge_requests_events, :issues_events]
      passed_events = available_events.select { |event| options[event] }
      events = Hash[passed_events.map { |event| [event, options[event]] }]

      post("/projects/#{project}/hooks", :body => {:url => url}.merge(events))
    end

    # Updates a project hook URL.
    #
    # @example
    #   Brat.edit_project_hook(42, 1, 'https://api.example.net/v1/webhooks/ci')
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of the hook.
    # @param  [String] url The hook URL.
    # @return [Brat::ObjectifiedHash] Information about updated hook.
    def edit_project_hook(project, id, url)
      put("/projects/#{project}/hooks/#{id}", :body => {:url => url})
    end

    # Deletes a hook from project.
    #
    # @example
    #   Brat.delete_project_hook('brat', 4)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [String] id The ID of the hook.
    # @return [Brat::ObjectifiedHash] Information about deleted hook.
    def delete_project_hook(project, id)
      delete("/projects/#{project}/hooks/#{id}")
    end

    # Mark this project as forked from the other
    #
    # @example
    #   Brat.make_forked(42, 24)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] id The ID of the project it is forked from.
    # @return [Brat::ObjectifiedHash] Information about the forked project.
    def make_forked_from(project, id)
      post("/projects/#{project}/fork/#{id}")
    end

    # Remove a forked_from relationship for a project.
    #
    # @example
    #  Brat.remove_forked(42)
    #
    # @param  [Integer, String] project The ID or name of a project.
    # @param  [Integer] project The ID of the project it is forked from
    # @return [Brat::ObjectifiedHash] Information about the forked project.
    def remove_forked(project)
      delete("/projects/#{project}/fork")
    end

    # Gets a project deploy keys.
    #
    # @example
    #   Brat.deploy_keys(42)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def deploy_keys(project, options={})
      get("/projects/#{project}/keys", :query => options)
    end

    # Gets a single project deploy key.
    #
    # @example
    #   Brat.deploy_key(42, 1)
    #
    # @param  [Integer, String] project The ID of a project.
    # @param  [Integer] id The ID of a deploy key.
    # @return [Brat::ObjectifiedHash]
    def deploy_key(project, id)
      get("/projects/#{project}/keys/#{id}")
    end

    # Creates a new deploy key.
    #
    # @example
    #   Brat.create_deploy_key(42, 'My Key', 'Key contents')
    #
    # @param  [Integer] project The ID of a project.
    # @param  [String] title The title of a deploy key.
    # @param  [String] key The content of a deploy key.
    # @return [Brat::ObjectifiedHash] Information about created deploy key.
    def create_deploy_key(project, title, key)
      post("/projects/#{project}/keys", body: {title: title, key: key})
    end

    # Deletes a deploy key from project.
    #
    # @example
    #   Brat.delete_deploy_key(42, 1)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Integer] id The ID of a deploy key.
    # @return [Brat::ObjectifiedHash] Information about deleted deploy key.
    def delete_deploy_key(project, id)
      delete("/projects/#{project}/keys/#{id}")
    end
  end
end
