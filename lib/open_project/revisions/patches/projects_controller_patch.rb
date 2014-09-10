module OpenProject::Revisions
  module Patches
    module ProjectsControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          alias_method_chain :update,    :revisions
          alias_method_chain :destroy,   :revisions

        end
      end

      module InstanceMethods

        def update_with_revisions(&block)

          update_without_revisions(&block)
          call_hook(:project_updated, :project => @project)
        end


        def destroy_with_revisions(&block)
          call_hook(:project_deletion_imminent, :project => @project, :confirm => api_request? || params[:confirm])
          destroy_without_revisions(&block)
        end

      end
    end
  end
end

ProjectsController.send(:include, OpenProject::Revisions::Patches::ProjectsControllerPatch)
