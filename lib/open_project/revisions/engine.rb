module OpenProject::Revisions
  class Engine < ::Rails::Engine
    engine_name :openproject_revisions

    include OpenProject::Plugins::ActsAsOpEngine

    register 'openproject-revisions',
      :author_url => 'https://github.com/oliverguenther/openproject-revisions',
      :requires_openproject => '>= 3.0.0'

    patches [ :Member, :ProjectsController, :RolesController, :RepositoriesController ]
  end
end
