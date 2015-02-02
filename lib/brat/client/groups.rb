class Brat::Client
  # Defines methods related to groups.
  module Groups
    # Gets a list of groups.
    #
    # @example
    #   Brat.groups
    #   Brat.groups(:per_page => 40)
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def groups(options={})
      get("/groups", :query => options)
    end

    # Gets a single group.
    #
    # @example
    #   Brat.group(42)
    #
    # @param  [Integer] id The ID of a group.
    # @return [Brat::ObjectifiedHash]
    def group(id)
      get("/groups/#{id}")
    end

    # Creates a new group.
    #
    # @param  [String] name The name of a group.
    # @param  [String] path The path of a group.
    # @return [Brat::ObjectifiedHash] Information about created group.
    def create_group(name, path)
      body = {:name => name, :path => path}
      post("/groups", :body => body)
    end

    # Get a list of group members.
    #
    # @example
    #   Brat.group_members(1)
    #   Brat.group_members(1, :per_page => 40)
    #
    # @param  [Integer] id The ID of a group.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def group_members(id, options={})
      get("/groups/#{id}/members", :query => options)
    end

    # Adds a user to group.
    #
    # @example
    #   Brat.add_group_member(1, 2, 40)
    #
    # @param  [Integer] team_id The group id to add a member to.
    # @param  [Integer] user_id The user id of the user to add to the team.
    # @param  [Integer] access_level Project access level.
    # @return [Brat::ObjectifiedHash] Information about added team member.
    def add_group_member(team_id, user_id, access_level)
      post("/groups/#{team_id}/members", :body => {:user_id => user_id, :access_level => access_level})
    end

    # Removes user from user group.
    #
    # @example
    #   Brat.remove_group_member(1, 2)
    #
    # @param  [Integer] team_id The group ID.
    # @param  [Integer] user_id The ID of a user.
    # @return [Brat::ObjectifiedHash] Information about removed team member.
    def remove_group_member(team_id, user_id)
      delete("/groups/#{team_id}/members/#{user_id}")
    end

    # Transfers a project to a group
    #
    # @param  [Integer] id The ID of a group.
    # @param  [Integer] project_id The ID of a project.
    def transfer_project_to_group(id, project_id)
      body = {:id => id, :project_id => project_id}
      post("/groups/#{id}/projects/#{project_id}", :body => body)
    end
  end
end
