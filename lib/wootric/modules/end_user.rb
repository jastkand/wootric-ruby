class Wootric::Client
  module EndUser

    def end_users(options = {})
      permitted_options = options.select do |key|
        [:page, :per_page, :created, :email, :sort_order].include?(key)
      end
      users = connection.get("end_users", permitted_options)
      users_json = JSON.parse(users.body)
      users_json
    end

    def find_end_user(user_id)
      user = connection.get("end_users/#{user_id}")
      user_json = JSON.parse(user.body)
      user_json
    end

    def create_end_user(email, options={})
      new_user = connection.post("end_users") do |req|
        req.params['email'] = email
        req.params['last_surveyed'] = options[:last_surveyed] unless options[:last_surveyed].nil?
        req.params['properties[company]'] = options[:company] unless options[:company].nil?
        req.params['properties[city]'] = options[:city] unless options[:city].nil?
      end
      new_user_json = JSON.parse(new_user.body)
      new_user_json
    end

    def edit_end_user(user_id, options={})
      edit_user = connection.put("end_users/#{user_id}") do |req|
        req.params['email'] = options[:email] unless options[:email].nil?
        req.params['last_surveyed'] = options[:last_surveyed] unless options[:last_surveyed].nil?
        req.params['external_created_at'] = options[:external_created_at] unless options[:external_created_at].nil?
        req.params['properties[company]'] = options[:company] unless options[:company].nil?
        req.params['properties[city]'] = options[:city] unless options[:city].nil?
      end
      new_user_json = JSON.parse(edit_user.body)
      new_user_json
    end

    def delete_end_user(user_id)
      user = connection.delete("end_users/#{user_id}")
      user_json = JSON.parse(user.body)
      user_json
    end

  end
end
