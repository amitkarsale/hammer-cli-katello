module HammerCLIKatello

  class HostCollection < HammerCLIKatello::Command
    resource :host_collections

    class ListCommand < HammerCLIKatello::ListCommand
      resource :host_collections, :index

      output do
        field :id, _("ID")
        field :name, _("Name")
        field :max_content_hosts, _("Limit")
        field :description, _("Description")
      end

      build_options
    end

    class CreateCommand < HammerCLIKatello::CreateCommand
      resource :host_collections, :create

      success_message _("Host collection created")
      failure_message _("Could not create the host collection")

      build_options
    end

    class InfoCommand < HammerCLIKatello::InfoCommand
      resource :host_collections, :show

      output ListCommand.output_definition do
        field :total_content_hosts, _("Total Content Hosts")
        field :max_content_hosts, _("Max Content Hosts")
      end

      build_options
    end

    class ContentHostsCommand < HammerCLIKatello::ListCommand
      resource :host_collections, :systems
      command_name "content-hosts"

      output do
        field :id, _("ID")
        field :uuid, _("UUID")
        field :name, _("Name")
      end

      build_options
    end

    class CopyCommand < HammerCLIKatello::CreateCommand
      resource :host_collections, :copy

      action :copy
      command_name "copy"

      success_message _("Host collection created")
      failure_message _("Could not create the host collection")

      validate_options do
        all(:option_name).required unless option(:option_id).exist?
      end

      build_options
    end

    class UpdateCommand < HammerCLIKatello::UpdateCommand
      success_message _("Host collection updated")
      failure_message _("Could not update the the host collection")

      build_options
    end

    class DeleteCommand < HammerCLIKatello::DeleteCommand
      resource :host_collections, :destroy

      success_message _("Host collection deleted")
      failure_message _("Could not delete the host collection")

      build_options
    end

    HammerCLIKatello::AssociatingCommands::ContentHost.extend_command(self)

    autoload_subcommands
  end
end

HammerCLI::MainCommand.subcommand 'host-collection', _("Manipulate host collections"),
                                  HammerCLIKatello::HostCollection