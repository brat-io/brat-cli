class Brat::Client
  # Defines methods related to repositories.
  module Branches
    # Gets a list of project repositiory branches.
    #
    # @example
    #   Brat.branches(42)
    #
    # @param  [Integer] project The ID of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Brat::ObjectifiedHash>]
    def branches(project, options={})
      get("/projects/#{project}/repository/branches", :query => options)
    end
    alias_method :repo_branches, :branches

    # Gets information about a repository branch.
    #
    # @example
    #   Brat.branch(3, 'api')
    #   Brat.repo_branch(5, 'master')
    #
    # @param  [Integer] project The ID of a project.
    # @param  [String] branch The name of the branch.
    # @return [Brat::ObjectifiedHash]
    def branch(project, branch)
      get("/projects/#{project}/repository/branches/#{branch}")
    end
    
    alias_method :repo_branch, :branch

    # Protects a repository branch.
    #
    # @example
    #   Brat.protect_branch(3, 'api')
    #   Brat.repo_protect_branch(5, 'master')
    #
    # @param  [Integer] project The ID of a project.
    # @param  [String] branch The name of the branch.
    # @return [Brat::ObjectifiedHash]
    def protect_branch(project, branch)
      put("/projects/#{project}/repository/branches/#{branch}/protect")
    end
    alias_method :repo_protect_branch, :protect_branch

    # Unprotects a repository branch.
    #
    # @example
    #   Brat.unprotect_branch(3, 'api')
    #   Brat.repo_unprotect_branch(5, 'master')
    #
    # @param  [Integer] project The ID of a project.
    # @param  [String] branch The name of the branch.
    # @return [Brat::ObjectifiedHash]
    def unprotect_branch(project, branch)
      put("/projects/#{project}/repository/branches/#{branch}/unprotect")
    end
    alias_method :repo_unprotect_branch, :unprotect_branch

    # Creates a repository branch.  Requires Brat >= 6.8.x
    #
    # @example
    #   Brat.create_branch(3, 'api')
    #   Brat.repo_create_branch(5, 'master')
    #
    # @param  [Integer] project The ID of a project.
    # @param  [String] branch The name of the new branch.
    # @param  [String] ref Create branch from commit sha or existing branch
    # @return [Brat::ObjectifiedHash]
    def create_branch(project, branch, ref)
      post("/projects/#{project}/repository/branches",:body => {:branch_name => branch, :ref => ref})
    end
    alias_method :repo_create_branch, :create_branch

  end
end

