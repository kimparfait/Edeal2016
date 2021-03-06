ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
     columns do
      column do
         panel "Recent Ads" do
           ul do
             Listing.limit(15).map do |listing|
              li link_to(listing.name, admin_listing_path(listing))
             end
          end
        end
      end

      columns do
      column do
         panel "Recent users" do
           ul do
             User.limit(5).map do |user|
              li link_to(user.name, admin_user_path(user))
             end
          end
        end
      end

      columns do
      column do
         panel "Recent orders" do
           ul do
             Order.limit(5).map do |order|
              li link_to(order.message, admin_order_path(order))
             end
          end
        end
      end



      column do
        panel "Info" do
         para "Welcome Admin."
         para" Edeal "
        end
      end
    end 
    end

  end # content

end
end
  

