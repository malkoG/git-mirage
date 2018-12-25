json.extract! repository, :id, :username, :repository_name, :temporary_path, :created_at, :updated_at
json.url repository_url(repository, format: :json)
