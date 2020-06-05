Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
      # 之後記得要換成 production site 網址

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: false

  end
end

# Rails 的 protection from forgery 機制會去比對 origin，把同源 csrf 檢查關閉
Rails.application.config.action_controller.forgery_protection_origin_check = false