ActiveAdmin.register_page "Dashboard" do

  


  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
    end

    panel "Recently Added Feedstocks" do
      table_for Feedstock.order("created_at DESC").limit(5) do
        column "Feedstock", :type do |feedstock|
          link_to feedstock.type, [:admin, feedstock]
        end
        column :created_at
      end
      strong { link_to "View all Feedstocks", admin_feedstocks_path }
    end

    
    panel "Recently Signed up Users" do
      table_for User.order("created_at DESC").limit(5) do
        column :email do |user|
          link_to user.email, [:admin, user]
        end
        column :created_at
      end
      strong { link_to "View all Users", admin_users_path }
    end


    # Here is an example of a simple dashboard with columns and panels.
    
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
