module OpenProject::Revisions
  module Patches
    module MemberPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          after_commit  :update_member
        end
      end

      module InstanceMethods

        private

        def update_member
          Redmine::Hook.call_hook(:membership_updated, :project => self.project)
        end
      end

    end
  end
end

Member.send(:include, OpenProject::Revisions::Patches::MemberPatch)
