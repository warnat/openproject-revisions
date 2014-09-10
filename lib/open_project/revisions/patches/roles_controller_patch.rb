module OpenProject::Revisions
  module Patches
    module RolesControllerPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods
          
          alias_method_chain :create,      :revisions
          alias_method_chain :update,      :revisions
          alias_method_chain :bulk_update, :revisions
          alias_method_chain :destroy,     :revisions
        end
      end


      module InstanceMethods

        def create_with_revisions(&block)
          # Do actual update
          create_without_revisions(&block)
          call_hook(:roles_changed, :message => 'created')
        end


        def update_with_revisions(&block)
          # Do actual update
          update_without_revisions(&block)
          call_hook(:roles_changed, :message => 'updated')
        end

        def bulk_update_with_revisions(&block)
          # Do actual update
          update_without_revisions(&block)
          call_hook(:roles_changed, :message => 'updated (bulk)')
        end


        def destroy_with_revisions(&block)
          # Do actual update
          destroy_without_git_hosting(&block)
          call_hook(:roles_changed, :message => 'destroyed')
        end
      end

    end
  end
end

RolesController.send(:include, OpenProject::Revisions::Patches::RolesControllerPatch)
